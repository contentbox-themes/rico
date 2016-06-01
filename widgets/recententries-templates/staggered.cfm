<cfoutput>
	<!--- title  --->
	<cfif len( arguments.title ) >
		<h#arguments.titleLevel# class="text-center">#arguments.title#</h#arguments.titleLevel#>
	</cfif>
	
	<!--- ul start  --->		
	<div class="media recentEntries">
		<!--- iterate and create --->
		<cfloop index = "x" from = "1" to = #arguments.max# >
			<cfif x is 1 or x mod 2 is 1>	
				<div class="recentEntry">
					<cfif entryResults.entries[ x ].getFeaturedImageURL() is not "">
						<div class="media-left text-left">
							<img src="#entryResults.entries[ x ].getFeaturedImageURL()#" alt="#entryResults.entries[ x ].getTitle()#" />
						</div>
					</cfif>
					<div class="media-body">
						<h#( arguments.titleLevel + 1 )#>
							<a href="#cb.linkEntry( entryResults.entries[ x ] )#">#entryResults.entries[ x ].getTitle()#</a><br/>
						</h#( arguments.titleLevel + 1 )#>
						<span class="entryDate">#DateFormat( entryResults.entries[ x ].getDisplayPublishedDate(), 'mmm d, yyyy' )#</span><br/>
						<div class="entryExcerpt"> #entryResults.entries[ x ].getExcerpt()#</div>
					</div>
				</div>
			<cfelse>
				<div class="recentEntry pull-right">
					<div class="media-body text-right">
						<h#( arguments.titleLevel + 1 )#>
							<a href="#cb.linkEntry( entryResults.entries[ x ] )#">#entryResults.entries[ x ].getTitle()#</a><br/>
						</h#( arguments.titleLevel + 1 )#>
						<span class="entryDate">#DateFormat( entryResults.entries[ x ].getDisplayPublishedDate(), 'mmm d, yyyy' )#</span><br/>
						<div class="entryExcerpt"> #entryResults.entries[ x ].getExcerpt()#</div>
					</div>
					<cfif entryResults.entries[ x ].getFeaturedImageURL() is not "">
						<div class="media-right">
							<img src="#entryResults.entries[ x ].getFeaturedImageURL()#" alt="#entryResults.entries[ x ].getTitle()#" />
						</div>
					</cfif>
				</div>
			</cfif>
		</cfloop>
	<!--- close ul --->
	</div>
</cfoutput>