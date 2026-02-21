package ru.cloudjava.loadtest;

import io.gatling.javaapi.core.ChainBuilder;
import io.gatling.javaapi.core.PopulationBuilder;
import io.gatling.javaapi.core.ScenarioBuilder;
import io.gatling.javaapi.core.Simulation;
import io.gatling.javaapi.http.HttpProtocolBuilder;

import java.time.Duration;
import java.util.Collection;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import static io.gatling.javaapi.core.CoreDsl.StringBody;
import static io.gatling.javaapi.core.CoreDsl.constantUsersPerSec;
import static io.gatling.javaapi.core.CoreDsl.exec;
import static io.gatling.javaapi.core.CoreDsl.jsonPath;
import static io.gatling.javaapi.core.CoreDsl.rampUsersPerSec;
import static io.gatling.javaapi.core.CoreDsl.scenario;
import static io.gatling.javaapi.http.HttpDsl.http;
import static io.gatling.javaapi.http.HttpDsl.status;
import static ru.cloudjava.loadtest.Constants.CLIENT_ID;
import static ru.cloudjava.loadtest.Constants.CLIENT_SECRET;
import static ru.cloudjava.loadtest.Constants.CREATE_ORDER_URL;
import static ru.cloudjava.loadtest.Constants.GATEWAY_ROOT_URL;
import static ru.cloudjava.loadtest.Constants.JANE;
import static ru.cloudjava.loadtest.Constants.JOHN;
import static ru.cloudjava.loadtest.Constants.KEYCLOAK_URL;
import static ru.cloudjava.loadtest.Constants.MAX;
import static ru.cloudjava.loadtest.Constants.MICHAEL;
import static ru.cloudjava.loadtest.Constants.PASSWORD;
import static ru.cloudjava.loadtest.Constants.RANDOM;

public class OrdersServiceLoadTest extends Simulation {

    private static final ConcurrentMap<String, String> TOKEN_BY_USERNAME = new ConcurrentHashMap<>();

    public OrdersServiceLoadTest() {
        HttpProtocolBuilder httpProtocolWithAccessToken = http
                .baseUrl(GATEWAY_ROOT_URL)
                .maxConnectionsPerHost(100)
                .shareConnections()
                .authorizationHeader(session -> getRandomUserToken());

        ScenarioBuilder maxTokenScenario = getTokenBuilder(MAX);
        ScenarioBuilder janeTokenScenario = getTokenBuilder(JANE);
        ScenarioBuilder johnTokenScenario = getTokenBuilder(JOHN);
        ScenarioBuilder michaelTokenScenario = getTokenBuilder(MICHAEL);

        setUp(
                maxTokenScenario.injectOpen(constantUsersPerSec(1).during(Duration.ofMinutes(5))),
                janeTokenScenario.injectOpen(constantUsersPerSec(1).during(Duration.ofMinutes(5))),
                johnTokenScenario.injectOpen(constantUsersPerSec(1).during(Duration.ofMinutes(5))),
                michaelTokenScenario.injectOpen(constantUsersPerSec(1).during(Duration.ofMinutes(5))),
                createOrderBuilder(httpProtocolWithAccessToken)
        );
    }

    private String getRandomUserToken() {
        Collection<String> values = TOKEN_BY_USERNAME.values();
        int tokenIdx = values.size() == 1 ? 1 : RANDOM.nextInt(0, values.size());
        return values.stream().skip(tokenIdx).findFirst().orElseThrow();
    }

    private ScenarioBuilder getTokenBuilder(String userName) {
        return scenario("Get Token %s".formatted(userName))
                .exec(
                        http("Get Keycloak Token")
                                .post(KEYCLOAK_URL)
                                .formParam("username", userName)
                                .formParam("password", PASSWORD)
                                .formParam("grant_type", "password")
                                .formParam("client_id", CLIENT_ID)
                                .formParam("client_secret", CLIENT_SECRET)
                                .formParam("scope", "openid roles")
                                .check(status().is(200))
                                .check(jsonPath("$.access_token").saveAs("access_token")))
                        .exec(session -> {
                            TOKEN_BY_USERNAME.put(userName, "Bearer " + session.getString("access_token"));
                            return session;
                        })
                        .pause(Duration.ofMinutes(4));
    }

    private PopulationBuilder createOrderBuilder(HttpProtocolBuilder protocolBuilder) {
        return scenario("Create order")
                .exec(callCreateOrder())
                .injectOpen(
                        constantUsersPerSec(2).during(Duration.ofSeconds(10)),
                        rampUsersPerSec(2).to(100).during(Duration.ofSeconds(30)),
                        constantUsersPerSec(100).during(Duration.ofSeconds(30)),
                        rampUsersPerSec(100).to(200).during(Duration.ofSeconds(30)),
                        constantUsersPerSec(200).during(Duration.ofSeconds(30)),
                        rampUsersPerSec(200).to(1000).during(Duration.ofMinutes(1)),
                        constantUsersPerSec(1000).during(Duration.ofMinutes(1)),
                        rampUsersPerSec(1000).to(2000).during(Duration.ofMinutes(1)),
                        constantUsersPerSec(2000).during(Duration.ofMinutes(1))
                ).protocols(protocolBuilder);
    }

    private ChainBuilder callCreateOrder() {
        return exec(
                http("Create Menu Order")
                        .post(CREATE_ORDER_URL)
                        .header("Content-Type", "application/json")
                        .body(StringBody(
                                """
                                {
                                    "nameToQuantity": {
                                        "One": 10,
                                        "Two": 20,
                                        "Three": 30
                                    },
                                    "address": {
                                        "city": "Moscow",
                                        "street": "Street",
                                        "house": 1,
                                        "apartment": 1
                                    }
                                }
                                """))
                        .check(status().is(201))
        );
    }
}
