package uk.org.hmrc.test

import reactivemongo.api.MongoConnection
import reactivemongo.api.collections.bson.BSONCollection
import reactivemongo.api.commands.{DefaultWriteResult, WriteResult}
import reactivemongo.bson.BSONDocument

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._
import scala.concurrent.{Await, Future}
import scala.util.{Failure, Random, Success}

/**
  * Created by walidus on 24/01/17.
  */
object ReactiveMongoMonitor extends App{

  val driver = new reactivemongo.api.MongoDriver

  val connection = driver.connection(List(//"localhost"
    "10.16.30.1:27017","10.16.31.1:27017","10.16.32.1:27017"
  ))

  def documentGenerator = BSONDocument(
    "something" -> Random.nextString(7)
  )

  val correctResponse = DefaultWriteResult(true,1,List(),None,None,None)
  println(s"A correct response is: $correctResponse. Any printed '.' signals such response. Any difference will be printed.")

  def insert(coll: BSONCollection, doc: BSONDocument): Future[Unit] = {
    val writeRes: Future[WriteResult] = coll.insert(doc)

    writeRes.onComplete { // Dummy callbacks
      case Failure(e) => e.printStackTrace()
      case Success(writeResult) =>
        if(correctResponse == writeResult)
          print(".")
        else
          print(" "+writeResult)
    }

    writeRes.map(_ => {}) // in this example, do nothing with the success
  }

  def dbFromConnection(connection: MongoConnection): Future[BSONCollection] =
    connection.database("somedatabase").
      map(_.collection("somecollection"))

  val collection = Await.result(dbFromConnection(connection), 5 seconds)

  while (true)  {
    insert(collection, documentGenerator)
    Thread.sleep(100)
  }

}
