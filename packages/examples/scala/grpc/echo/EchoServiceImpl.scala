package packages.examples.scala.grpc.echo

import akka.NotUsed
import akka.actor.ActorSystem
import akka.grpc.scaladsl.Metadata
import akka.stream.Materializer
import akka.stream.scaladsl.{BroadcastHub, Keep, MergeHub, Source}
import packages.examples.echo.{
  EchoRequest,
  EchoResponse,
  EchoServicePowerApi,
  StreamEchoRequest,
  StreamEchoResponse
}

import scala.concurrent.{ExecutionContextExecutor, Future}

class EchoServiceImpl(implicit materializer: Materializer) extends EchoServicePowerApi {

  implicit val actorSystem: ActorSystem = materializer.system
  implicit val executionContext: ExecutionContextExecutor = materializer.executionContext

  val (sink, source) = MergeHub
    .source[String](perProducerBufferSize = 16)
    .toMat(BroadcastHub.sink(bufferSize = 256))(Keep.both)
    .run()

  override def echo(in: EchoRequest, metadata: Metadata): Future[EchoResponse] = {
    Source.single(in.message).runWith(sink)
    Future.successful(EchoResponse(in.message, System.currentTimeMillis()))
  }

  override def streamEcho(
      in: StreamEchoRequest,
      metadata: Metadata
  ): Source[StreamEchoResponse, NotUsed] = {
    source
      .filter(message => message.contains(in.pattern))
      .map(message => StreamEchoResponse(message, System.currentTimeMillis()))
  }
}
