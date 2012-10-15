<h3>And Now for Something Entirely Different</h3>
<p>Ok, so subqueries are working. <strong style="color:green;">CHECK</strong>.</p>
<p>At this point, I should be happy, I should be satisfied with it <em>working</em>. But I'm not. Why? Because I suddenly need to create a report that I still 
can't get CriteriaBuilder to spit out, even with my new subqueries. *Sigh*.</p>
<h4>The Report</h4>
<p>For this report, I want to deal with the same data and criteria as before, but I now need to also get back some projected values. Specifically, I want:</p>
<ul>
    <li>Number of vehicles made prior to 2005</li>
    <li>Number of vehicels made after 2005</li>
    <li>...and of course, with the same criteria as before (only cars with insured drivers older than 26)</li>
</ul>
<p>Out of the box, the only way you could really get this with CriteriaBuilder is by doing two separate queries, and combining after the fact.
While this works, it kind of defeats the purpose toward which we've been building, right?</p>
<p>No fear--sqlProjections to the rescue!</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page8')#</cfoutput>">>> SQLProjection()</a></strong></p>