<h3>The Data</h3>
<p>Ok, first things first. The data. For the following examples, I'm going to be using a fairly simple data model that revolves around Cars and Drivers.</p>
<p>A synopsis of the data structure and relationships are below (look at the code for more in-depth view).</p>
<h4>Car.cfc</h4>
<ul>
    <li>CarID</li>
    <li>Make</li>
    <li>Model</li>
    <li>Year</li>
</ul>
<h4>Driver.cfc</h4>
<ul>
    <li>DriverID</li>
    <li>Name</li>
    <li>Age</li>
</ul>
<h4>Insured.cfc</h4>
<ul>
    <li>InsuredID</li>
    <li>CarID</li>
    <li>DriverID</li>
</ul>
<h4>ORM Relationships</h4>
<p>Since this is in the domain of ORM, here are the relationships between entities:</p>
<ul>
    <li>
        <strong>Car -> Insured:</strong> property name="InsuredDrivers" fieldtype="one-to-many" cfc="Driver" fkcolumn="CarID" linktable="Insured" inversejoincolumn="DriverID";
    </li>
    <li>
        <strong>Insured -> Driver:</strong> 	property name="DriverID" fieldtype="many-to-one" cfc="Driver" fkcolumn="DriverID";
    </li>
    <li>
    	<strong>Insured -> Car:</strong> 	property name="CarID" fieldtype="many-to-one" cfc="Car" fkcolumn="CarID";
    </li>
</ul>
<h3>The Goal</h3>
<p>As you'll see through the following examples, there are actually a number of ways to get at the solution I need. However, not all fulfill the requirements I have.
<p>But ultimately, my goal--the impetus for this entire project--is very simple. <strong style="color:red;">I want to get a list of cars that have insured drivers who are over the age of 26</strong>. Simple, right? We'll see...</p>
<h3>Requirements</h3>
<h4>Return Format</h4>
<p>To understand the requirements I had that compelled me to explore this issue, you'll need some context. Imagine an AJAX app that has a number of data grids. In order for the data grid to work
properly, the response coming from the server needs to have not only the data, but also a count of the total records for a given data set (you know, for paging and what-not).</p>
<p>So imagine I have a data grid that displays data, 50 records per "page". Every time I advance page to page, the response coming back from the server needs to look something like:</p>
<pre>
{
    "count": 2525,
    "data": [
    	{ data1... },
        { data2... },
        { etc. x50 }
    ]
}
</pre>
<p>In order to do this, I have a single method through which all my Criteria Builder requests are funneled. This method, among other things, does something like:</p>
<pre>
var result = {
    count=c.count(),
    data =c.list( argumentCollection=arguments )
};
return result // serialize as part of an ajax request via proxy...
</pre>
<p>The important part of this consideration is that I NEED count() and list() to give me back the same data. That is, when I run this single method, I don't want to have to massage the count or data in order to get the right values for each.</p>
<h4>Build Criteria Dynamically</h4>
<p>This is a big requirement. Since I have a lot of entry points in the app, but only one "exit" for all Criteria queries, I need a common, dynamic-ish way to build criteria queries. Hard-coding will not work here.</p>
<p>Also, in case you're wondering, I also really don't want to do on-the-fly string building (more on this too).</p>
<p>In general, my desired approach will be to build criteria queries per-concrete service. So consider the following in a concrete service:</p>
<pre>
// deserialized array of filters coming from url
var filters = [
    { property="Make", value="Ford" },
    { property="Model", value="Escort" }
];
var c = newCriteria();
// loop over filters and add them to criteria builder
for( filter in filters ) {
    var prop = filter.property;
    var value= filter.value;
    if( prop=="Make" ) {
    	c.iLike( prop, value );
    }
    if( prop=="Model" ) {
    	c.iLike( prop, value );
    }
    if( prop=="Year" ) {
    	c.isEQ( prop, value );
    }
    ...
}
var result = {
    count=c.count(),
    data =c.list( argumentCollection=arguments )
};
</pre>
<p>So that's about it. Ready? Onward!</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page2')#</cfoutput>">>> Try #1: Alias</a></strong></p>