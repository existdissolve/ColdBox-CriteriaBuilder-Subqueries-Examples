<h3>How about a SQL Restriction?</h3>
<p>What about a <a href="http://wiki.coldbox.org/wiki/Extras:CriteriaBuilder.cfm#Restrictions">SQLRestriction</a>? This basically allows you to send along an arbitrary string of SQL which will be incorporated into your criteria query. Let's try it:</p>
<pre>
var c = newCriteria();
c.sqlRestriction( 
    "CarID in ( 
        select	CarID 
        from 	Insured i 
        join 	Driver d on i.DriverID=d.DriverID 
        where 	d.Age < #arguments.Age# 
    )" 
);
var results = {
    data = c.list( asquery=true ),
    count = c.count()
};
</pre>
<cfdump var="#prc.results#">
<p>Hmm, so that worked..ish. The count matches the data returned. The big problem, though? Not realistic if I'm dynamically creating this criteria. To use this,
I'd need to either concatenate strings (YUK), or hard-code every flavor of restriction, every time I need it. Blech.
<p>Have we hit a wall? Yes. Despair, all you who enter here. Just kidding. Keep reading.</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page5')#</cfoutput>">>> Pit Stop: Let's Regroup</a></strong></p>