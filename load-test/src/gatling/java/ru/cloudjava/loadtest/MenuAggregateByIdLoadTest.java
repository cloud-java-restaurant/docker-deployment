package ru.cloudjava.loadtest;

import io.gatling.javaapi.core.ChainBuilder;
import io.gatling.javaapi.core.PopulationBuilder;
import io.gatling.javaapi.core.Simulation;
import io.gatling.javaapi.http.HttpProtocolBuilder;

import java.time.Duration;

import static io.gatling.javaapi.core.CoreDsl.constantUsersPerSec;
import static io.gatling.javaapi.core.CoreDsl.exec;
import static io.gatling.javaapi.core.CoreDsl.rampUsersPerSec;
import static io.gatling.javaapi.core.CoreDsl.scenario;
import static io.gatling.javaapi.http.HttpDsl.http;
import static io.gatling.javaapi.http.HttpDsl.status;
import static ru.cloudjava.loadtest.Constants.GATEWAY_ROOT_URL;
import static ru.cloudjava.loadtest.Constants.MENU_AGGREGATE_URL;
import static ru.cloudjava.loadtest.Constants.RANDOM;

public class MenuAggregateByIdLoadTest extends Simulation {

    public MenuAggregateByIdLoadTest() {
        HttpProtocolBuilder protocolBuilder = http
                .baseUrl(GATEWAY_ROOT_URL)
                .maxConnectionsPerHost(100)
                .shareConnections();
        setUp(getMenuAggregateBuilder().protocols(protocolBuilder));
    }

    private PopulationBuilder getMenuAggregateBuilder() {
        return scenario("Get menu aggregate")
                .exec(callGetMenuAggregate())
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
                );
    }

    private ChainBuilder callGetMenuAggregate() {
        return exec(
                http("Call Get Menu Aggregate")
                        .get(MENU_AGGREGATE_URL + RANDOM.nextInt(1, 4))
                        .check(status().is(200)));
    }

}
