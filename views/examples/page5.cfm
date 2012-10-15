<h3>Pit Stop</h3>
<p>Alright, let's recap. To this point, we've run into two issues:
<ul>
    <li>Using createAlias() and resultTransformer() will give us duplicate results for count and/or list (boooo)</li>
    <li>sqlRestriction() works, but it's not realistic or feasible for dynamic creation of criteria (boooo)</li>
</ul>
</p>
<p>I'll be honest: at this point in my journey, I got severely frustrated. I didn't know if a solution was possible, so I was honestly considering developing some kind of
cursed string builder so that I could leverage sqlRestriction(). Fortunately, before I went down this destructive path, I came across the thing which 
inevitably saved my life (or at least gave me a solution to this issue!).</p>
<h3>Onward and Upward</h3>
<p>From this point on, we leave behind the frustration of failure and disappointment of hacky solutions...and enter into the land of real examples which solve this problem.</p>
<p>Admission is free, but we do ask that you tip your waiter.</p>
<p><strong><a href="<cfoutput>#event.buildLink(linkto='general.page6')#</cfoutput>">>> A Simple Subquery</a></strong></p>