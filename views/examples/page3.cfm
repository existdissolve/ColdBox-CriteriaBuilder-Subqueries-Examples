<h3>Using a Result Transformer</h3>
<p>Well, no biggie, right? Just need to filter out that duplicate record. Using a <a href="http://wiki.coldbox.org/wiki/Extras:CriteriaBuilder.cfm#Result_Transformers">ResultTransformer</a> will fix this, right?</p>
<pre>
var c = newCriteria();
    c.createAlias( "InsuredDrivers", "id" )
     .isGT( "id.Age", javaCast( "int", arguments.Age ) )
     .resultTransformer( c.DISTINCT_ROOT_ENTITY );
var results = {
    data = c.list( asquery=true ),
    count = c.count()
};   
</pre>
<cfdump var="#prc.results#">
<h4>Another Dead-End</h4>
<p>While the result transformer gets me a unique <em>data set</em>, it doesn't help with the <strong>count</strong> whatsoever. If I'm counting on (lol...) the count and data result matching each other, this isn't going to work.
I mean, imagine if you have a data-driven grid with paging based on this result...lol!</p>
<p>Let's try one more thing.</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page4')#</cfoutput>">>> Try #3: SQLRestriction</a></strong></p>