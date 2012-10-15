<h3>A Simple Subquery</h3>
<p>In the magical realm of the Hibernate API, there is the notion of a <a href="http://docs.jboss.org/hibernate/orm/3.5/api/org/hibernate/criterion/DetachedCriteria.html">DetachedCriteria</a>. According to the docs, the DetachedCriteria "...
allows you to create a query outside the scope of a session and then execute it using an arbitrary Session...[and] can also be used to express a subquery."</p>
<p>Seriously? That's perfect. After all, a *subquery* is PRECISELY what is needed to get the data in the format that I want. Hooray!</p>
<h4>Anatomy of a Subquery (DetachedCriteria)</h4>
<p>The brilliant part about using DetachedCriteria in ColdBox's CriteriaBuilder is that it's pretty similar in syntax to regular criteria queries. Enough explaination: let's see an example!</p>
<pre>
var c = newCriteria();
    c.add(
        c.createSubcriteria( "Car", "CarSub" )
         <strong>.withProjections( property="CarID" )</strong>
         .createAlias( "InsuredDrivers", "id" )
         .isGT( "id.Age", javaCast( "int", arguments.Age) )
         <strong>.propertyIn( "CarID" )</strong>
    );
var results = {
    data = c.list( asquery=true ),
    count = c.count()
};
return results;    
</pre>
<p>And the SQL:</p>
<pre>
select	*
from	Car this_ 
where	this_.CarID in (
    select CarSub_.CarID as y0_ 
    from Car CarSub_ 
    inner join Insured insureddri3_ on CarSub_.CarID=insureddri3_.CarID 
    inner join Driver id1_ on insureddri3_.DriverID=id1_.DriverID 
    where id1_.Age>26
)
</pre>
<cfdump var="#prc.results#">
<p>First of all, awesome. That totally worked. Not only did I get back the correct data set, but the count also matches! Hooray :)
<h4>Using DetachedCriteria</h4>
<p>Now that we have something which is working, let's talk about how it gets put together.</p>
<h5>createSubcriteria()</h5>
<p>A DetachedCriteria is created by calling the createSubcriteria() method on the main criteria query. This method requires two arguments: The <strong>entityname</strong>, and the <strong>alias</strong> that should be used for it. Simple.</p>
<h5>withProjections(...)</h5>
<p>Unlike with the base CriteriaBuilder, the DetachedCriteria builder <em>needs</em> a projection. If you think about it, this makes sense. After all, 
for a subquery to work, you need to return *something* ("CarID", in this example) to compare to some property
on the root table., Specifying either a property, count, or some other projection will make this work.</p>
<h5>The Actual Subquery</h5>
<p>In order for this to all come together, we need to add a "Subquery" to the main criteria query. This is done via the <strong>criterion/Subqueries.cfc</strong>. You can
use any of the methods defined in this component to determine how the subquery will be built out.</p>
<p>In this example, I've decided to do a "propertyIn()" subquery. By specifying that I want to use the "CarID" property, this will create a subquery
that will only return results where the CarID of the data is found in the result set of the subquery.</p>
<p><strong>IMPORTANT:</strong> If you're paying attention, you've probably noticed that the values of the withProjection() and propertyIn() are the same. While the correspondence of these 
will vary depending on the type of subquery you want to run, you'll want to make sure that what you want to compare on the root query is compatible with what is being returned from the subquery. 
Believe me, this will save a lot of debugging frustration :).</p>

<h4>Another Approach</h4>
<p>In the example above, I built out the entire DetachedCriteria within the add() of the main criteria query. If you want to separate these out a bit,
that's totally possible:</p>
<pre>
var c = newCriteria();
var sc = c.createSubcriteria( "Car", "CarSub" )
          .withProjections( property="CarID" )
          .createAlias( "InsuredDrivers", "id" )
          .isGT( "id.Age", javaCast( "int", arguments.Age) );
c.add( sc.propertyIn( "CarID" ) );
</pre>
<p>This will give us exactly the same result, since the only thing that's ultimately getting added to the crtieria query is the Subquery expression which is returned
from any of the methods in the criterion/Subqueries.cfc component.</p>
<p>So the choice is yours--you can build it all out together, or piece it together dynamically, depending on your requirements.</p>
<h4>Multiple Subqueries? Absolutely!</h4>
<p>Yes, you can totally do multiple subqueries.</p>
<pre>
var c = newCriteria();
    c.add(
        c.createSubcriteria( "Car", "CarSub" )
         .withProjections( property="CarID" )
         .createAlias( "InsuredDrivers", "id" )
         .isGT( "id.Age", javaCast( "int", arguments.Age) )
         .propertyIn( "CarID" )
        )
     .add(
        c.createSubcriteria( "Car", "CarSub2" )
         .withProjections( property="CarID" )
         .createAlias( "InsuredDrivers", "id" )
         .isEQ( "id.Name", "Jared" )
         .propertyIn( "CarID" )
     );
</pre>
<p>Obviously, in this example, it would probably make more sense (depending on your requirements) just to constrain the original subquery a bit more. But it still does the job :)</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page7')#</cfoutput>">>> Now, Something Completely Different...</a></strong></p>

