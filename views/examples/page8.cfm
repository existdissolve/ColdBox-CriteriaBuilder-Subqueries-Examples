<h3>Enter the SQL Projection</h3>
<p>Fortunately, the Hibernate criteria API has two projections--<a href="http://docs.jboss.org/hibernate/orm/3.5/api/org/hibernate/criterion/SQLProjection.html">sqlProjection() and sqlGroupProjection()</a>--which enable you to send through arbitrary
SQL, just as with sqlRestriction(). However, unlike sqlRestriction(), sqlProjection() and sqlGroupProjection() do not add criteria, but rather <em>add projections to the criteria</em>.</p>
<p>What does this mean? Simply this: whatever SQL you provide will be added to the final query's "select" clause, rather than the "where". 
Make sense? Let's see an example:</p>
<h4>sqlProjection()</h4>
<pre>
var c = newCriteria();
    c.add(
        c.createSubcriteria( "Car", "CarSub" )
         .withProjections( property="CarID" )
         .createAlias( "InsuredDrivers", "id" )
         .isGT( "id.Age", javaCast( "int", arguments.Age) )
         .propertyIn( "CarID" )
    )
     .withProjections(
         sqlProjection=[
            {
                sql = "select count(Year) from Car where Year < 2006 and CarID=<strong>{alias}.CarID</strong>",
                alias = "TotalMakePre2006",
                property="Year"
            },
            {
                sql = "select count(Year) from Car where Year > 2005 and CarID=<strong>{alias}.CarID</strong>",
                alias = "TotalMakePost2005",
                property="Year"
            }
        ],
        groupProperty="Make"
    );
var results = {};
results.data = c.list();
results.count= arrayLen( results.data );    
</pre>
<cfdump var="#prc.result1#">
<p>...and the SQL:</p>
<pre>
select 	this_.Make as y0_,
    (
    	select 	count(Year)  
        from 	Car 
        where 	Year < 2006 
            and CarID=this_.CarID
    ) as TotalMakePre2006,
    (
    	select 	count(Year)  
        from 	Car 
        where 	Year > 2005 
            and CarID=this_.CarID
    ) as TotalMakePost2005
from	Car this_ 
where	this_.CarID in (
    select	CarSub_.CarID as y0_ 
    from 	Car CarSub_ 
    inner join Insured insureddri3_ on CarSub_.CarID=insureddri3_.CarID 
    inner join Driver id1_ on insureddri3_.DriverID=id1_.DriverID 
	where	id1_.Age>26
) 
group by this_.Make
</pre>
<p>
    So <strong>sqlProjection</strong> allows you to pass through either a single configuration, or an array or sqlProjection configs. These configs look like:</p>
<ul>
    <li><strong>sql:</strong> The sql string you want to execute</li>
    <li><strong>alias:</strong> The alias that will be used for the subquery</li>
    <li><strong>property:</strong> The property being projected</li>
</ul>
<p>You'll also notice that in each of the projections, I rooted each subquery to the CarID of the root query by using the "{alias}" syntax. When the query
is executed, this will result in the CarID of the subquery being bound to the CarID of the root query table (e.g., "this_").</p>
<p>Finally, I simply added in a normal <strong>groupProperty</strong> projection to make the results show up a bit better, and group by something meaningful.

<h4>sqlGroupProjection()</h4>
<p>The sqlGroupProjection() is exactly the same as the sqlProjection(), except that it requires an additional "group" configuration value.</p>
<cfdump var="#prc.result2#">
<p><strong>NOTE:</strong> Using sqlGroupProjection() is pretty much precisely the same as using sqlProjection() and groupProperty() in conjunction with one another (as in the first example).</p>
<p>The only real difference is that sqlGroupProjection() will handle adding the "group by" without the need for groupProperty.</p>

<h3>What, You Want More?</h3>
<p>Yay, this is working. But it could always be better, right? After all, by using sqlProjection() or sqlGroupProjection(), we're still building strings 
for the projection SQL...not a fan.</p>
<p>What if we didn't have to do that? Hmm....</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page9')#</cfoutput>">>> detachedSQLProjection()</a></strong></p>

