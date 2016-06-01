<cfoutput>
	<div id="carousel-category-#arguments.category#" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner" role="listbox">
			<ol class="carousel-indicators">
				<!--- iterate and create indicators --->
				<cfloop index = "x" from = "1" to = #arguments.max# >
					<cfif x == 1 >
						<cfset activeClass = 'class="active"' >
					<cfelse>
						<cfset activeClass = "">	
					</cfif>
					
					<li data-target="##carousel-category-#arguments.category#" data-slide-to="#x#-1" #activeClass#></li>
					
				</cfloop>
			
			</ol>
			<!---  iterate and create --->
			<cfloop index = "x" from = "1" to = #arguments.max# >
				<cfset	tempPath = contentResults.content[ x ].getCustomField( "imageURL", "" ) >
				<cfset	tempTitle = contentResults.content[ x ].getTitle() >
				<cfset	tempLink = contentResults.content[ x ].getCustomField( "linkURL", "" ) >
				<cfset	tempLinkText = contentResults.content[ x ].getCustomField( "linkText", "" ) >
						
				<cfif x is 1 >
					 <div class="item active">
				<cfelse>
					<div class="item">
				</cfif>
					
				<cfif tempPath is not "">
					<img src="#tempPath#" class="carousel-img" alt="#tempTitle#"/>
				</cfif>
					
					<div class="carousel-caption">
						<h#arguments.titleLevel# class="title">
							<a href="#tempLink#">#tempTitle#</a>
						</h#arguments.titleLevel#>
						<div class="desc">#contentResults.content[ x ].getDescription()#</div>
						
						<cfif tempLink is not "" and tempLinkText is not "">
							<a href="#tempLink#"class="btn btn-default">#tempLinkText#</a>
						</cfif>
					</div>
				</div>
			</cfloop>
		</div>
	</div>
</cfoutput>