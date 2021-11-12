package packages.examples.scala.grpc.echo

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.stream.SystemMaterializer
import com.typesafe.config.ConfigFactory
import packages.examples.echo.EchoServicePowerApiHandler

import scala.concurrent.{ExecutionContext, Future}

object EchoServer {
  def main(args: Array[String]): Unit = {
    println(util.Properties.versionString)
    val conf = ConfigFactory
      // TODO: Support application.conf
      .parseString("akka.http.server.preview.enable-http2 = on")
      .withFallback(ConfigFactory.defaultApplication())

    val system = ActorSystem("echo-service", conf)
    new EchoServer(system).run()
  }
}

class EchoServer(system: ActorSystem) {
  def run(): Future[Http.ServerBinding] = {
    // Akka boot up code
    implicit val sys: ActorSystem = system
    implicit val ec: ExecutionContext = sys.dispatcher

    val service = EchoServicePowerApiHandler(new EchoServiceImpl())
    val binding = Http().newServerAt("127.0.0.1", 8080).bind(service)

    binding.foreach { binding => println(s"gRPC server bound to ${binding.localAddress}") }

    binding
  }
}
