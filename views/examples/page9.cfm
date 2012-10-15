<h3>DetachedCriteria Doing Double Duty</h3>
<p>I was quite surprised to discover that beyond allowing for the awesomeness of subqueries, DetachedCriteria has a way--albeit around-about one--of
 letting us use it for sqlProjection(). What this means, of course, is that instead of dirtying our hands with building strings to pass through to sqlProjection(), 
 we can simply use the built-in goodness of DetachedCriteria and leverage it to auto-magically create the SQL for us for sqlProjection().</p>
 <p>Here's the same example we just ran, but this time using a more sane approach:</p>
<pre>
var c = newCriteria();
    c.add(
        // create the subquery
        c.createSubcriteria( "Car", "CarSub" )
         .withProjections( property="CarID" )
         .createAlias( "InsuredDrivers", "id" )
         .isGT( "id.Age", javaCast( "int", arguments.Age) )
         .propertyIn( "CarID" )
    )
    // add projections
    .withProjections(
        detachedSQLProjection=[
            // first SQLProjection
            c.createSubcriteria( "Car", "Car2" )
             .withProjections( count="Car2.Year" )
             .isLT( "Year", javaCast( "int", 2006 ) )
             .isEQ( "CarID", "{alias}.CarID" ),
            // second SQLProjection
            c.createSubcriteria( "Car", "Car3" )
             .withProjections( count="Car3.Year" )
             .isGT( "Year", javaCast( "int", 2005 ) )
             .isEQ( "CarID", "{alias}.CarID" )
       ],
       groupProperty="Make"
   );
// get the results               
var results = {};
    results.data = c.list();
    results.count= arrayLen( results.data );
return results;
</pre>
<cfdump var="#prc.results#">
<p>...and the SQL:</p>
<pre>
select	this_.Make as y0_,
    ( 
        select	count(Car2.`Year`) as y0_ 
        from    Car Car2 
        where   Car2.`Year`<2006 
            and Car2.CarID=this_.CarID 
    ) as this_Car2,
    ( 
        select  count(Car3.`Year`) as y0_ 
        from    Car Car3 
        where   Car3.`Year`>2005 
            and Car3.CarID=this_.CarID 
    ) as this_Car3 
from	Car this_ 
where	this_.CarID in (
    select  CarSub_.CarID as y0_ 
    from    Car CarSub_ 
    inner join Insured insureddri3_ on CarSub_.CarID=insureddri3_.CarID 
    inner join Driver id1_ on insureddri3_.DriverID=id1_.DriverID 
    where   id1_.Age>26
) 
group by this_.Make
</pre>
<p>Notice that we get precisely the same result as when we passed the manually built SQL strings through sqlProjection(), but without the messiness of string building. Hooray! :)</p>