<h3>A Simple Alias</h3>
<p>Alright, let's try this out with a simple alias. Using CriteriaBuilder's <a href="http://wiki.coldbox.org/wiki/Extras:CriteriaBuilder.cfm#Associations">createAlias()</a>, we can easily drill down from the <strong>Car</strong> entity
 to the <strong>Driver</strong> entity (via the InsuredDrivers relationship) in order to filter our results by drivers who are over the age of 26:</p>
<pre>
var c = newCriteria();
    c.createAlias( "InsuredDrivers", "id" )
     .isGT( "id.Age", javaCast( "int", arguments.Age ) );
var results = {
    count = c.count(),
    data = c.list( asquery=true )
};
return results;    
</pre>
<p>Pretty simple, right? Here are the results:
<cfdump var="#prc.results#">
<p>...and the SQL:</p>
<pre>
select *
from	Car this_ 
inner join Insured insureddri3_ on this_.CarID=insureddri3_.CarID 
inner join Driver id1_ on insureddri3_.DriverID=id1_.DriverID 
where id1_.Age>26
</pre>
<h4>Ohnoes</h4>
<p>Whoops. Notice the joins. These were needed, because I had to drill down into the Driver table in order to execute my query for cars based on the ages of the insured drivers.
However, because of this join, I now have duplicate results (the Saturn Aura). While there are really 3 cars with drivers over the age of 26, I get 4 results back...because one of these cars
has two drivers over the age of 26.</p>
<p>So obviously this won't work. Let's try something else.</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page3')#</cfoutput>">>> Try #2: ResultTransformer</a></strong></p>