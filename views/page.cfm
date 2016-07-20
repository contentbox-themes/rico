<cfoutput>
<!--- View Arguments --->
<cfparam name="args.print" 		default="false">
<cfparam name="args.sidebar" 	default="true">

<cfset prc.entriesTitle = cb.themeSetting( 'entriesTitle', '' )>
<cfset prc.entriesCategory = html.slugify( cb.themeSetting( 'entriesCategory', 'none' ) )>

<cfif cb.themeSetting( 'secQuoteImgBg', '' ) is not "">
	<cfset prc.secQuoteImgBg = 'style="background-image: url(' & cb.themeSetting( 'secQuoteImgBg' ) & ')"'>
<cfelse>
	<cfset prc.secQuoteImgBg = "">
</cfif>

<cfset prc.csCategory = html.slugify( cb.themeSetting( 'csCategory', 'none' ) )>

<cfif cb.isHomePage()>
	<cfif cb.themeSetting( 'hpArticleText','' ) is not "">
		<!--- Section 1 --->
		<section id="section-1">
			<div class="container article">
				<h2>#cb.themeSetting( 'hpArticleTitle','' )#</h2>
				<div class="article-content">
					<div class="col-md-5">
						<div class="article-text">#cb.themeSetting( 'hpArticleText','' )#</div>
						<cfif cb.themeSetting( 'hpArticleBtnURL','' ) is not ''>
							<a class="btn btn-lg btn-danger" herf="#cb.themeSetting( 'hpArticleBtnURL','' )#">#cb.themeSetting( 'hpArticleBtnText','More' )#</a>
						</cfif>
					</div>
					<cfif cb.themeSetting( 'hpArticleImg','' ) is not ''>
						<div class="col-md-7">
							<img class="img-responsive article-img" src="#cb.themeSetting( 'hpArticleImg','' )#" alt="#cb.themeSetting( 'hpArticleTitle','' )#">
						</div>
					</cfif>
				</div>
			</div>
		</section><!--- end section 1 --->
	</cfif>
	
	<!--- Section 2 --->
	<cfif cb.themeSetting( 'secQuoteText','' ) is not "">
		<section id="section-2" #prc.secQuoteImgBg#>
			<div class="container">
				<div class="section-text-box">
					<div class="section-text">
						#cb.themeSetting( 'secQuoteText' )#
					</div>
				</div>
			</div>
		</section>
	</cfif>
	<!--- end section 2 --->
	
	<!--- Section 3 --->
	<cfif prc.entriesCategory is not "none">					
		<section id="section-3">
			<div class="container">
				#cb.widget( name='RecentEntries',args={title=prc.entriesTitle,category=prc.entriesCategory,widgetTemplate='staggered'} )#
			</div>
		</section>
	</cfif>
	<!--- end section 3 --->
	
	<!--- Section 4 --->
	<cfif prc.csCategory is not "none">					
		<section id="section-4">
			<div class="container">
				#cb.widget( name='ContentStoreGrid',args={category=prc.csCategory} )#
				<cfif cb.themeSetting( 'csBtnURL', '' ) is not ''>
					<div class="col-md-12 text-center">
						<a class="btn btn-trans-dark" href="#cb.themeSetting( 'csBtnURL', '' )#"> #cb.themeSetting( 'csBtnText', 'More' )#</a>
					</div>
				</cfif>
			</div>
		</section>
	</cfif>
	<!--- end section 4 --->
	
	
<cfelse>
	<!--- ContentBoxEvent --->
	#cb.event( "cbui_prePageDisplay" )#
	
	<!--- Body Main --->
	<section id="body-main">
		<div class="container">
	
			<!--- Export and Breadcrumbs Symbols --->
			<cfif !args.print AND !isNull( "prc.page" ) AND prc.page.getSlug() neq cb.getHomePage()>
				<!--- Exports --->
				<div class="btn-group pull-right">
					<button type="button" class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" title="Export Page...">
						<i class="fa fa-print"></i> <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li><a href="#cb.linkPage( cb.getCurrentPage() )#.print" target="_blank">Print Format</a></li>
						<li><a href="#cb.linkPage( cb.getCurrentPage() )#.pdf" target="_blank">PDF</a></li>
					</ul>
				</div>
	
				<!--- BreadCrumbs --->
				<div id="body-breadcrumbs" class="col-sm-12">
					<i class="fa fa-home"></i> #cb.breadCrumbs( separator="<i class='fa fa-angle-right'></i> " )#
				</div>
			</cfif>
	
			<!--- Determine span length due to sidebar or homepage --->
			<cfif cb.isHomePage() OR !args.sidebar>
				<cfset variables.span = 12>
			<cfelse>
				<cfset variables.span = 9>
			</cfif>
			<div class="col-sm-#variables.span#">
				
				<!--- Render Content --->
				#prc.page.renderContent()#
	
				<!--- Comments Bar --->
				<cfif cb.isCommentsEnabled( prc.page )>
				<section id="comments">
					#html.anchor( name="comments" )#
					<div class="post-comments">
						<div class="infoBar">
							<p>
								<button class="button2" onclick="toggleCommentForm()"> <i class="icon-comments"></i> Add Comment (#prc.page.getNumberOfApprovedComments()#)</button>						
							</p>
						</div>
						<br/>
					</div>
	
					<!--- Separator --->
					<div class="separator"></div>
	
					<!--- Comment Form: I can build it or I can quick it? --->
					<div id="commentFormShell">
						<div class="row">
							<div class="col-sm-12">
								#cb.quickCommentForm(prc.entry)#
							</div>
						</div>
					</div>
	
					<!--- clear --->
					<div class="clr"></div>
	
					<!--- Display Comments --->
					<div id="comments">
						#cb.quickComments()#
					</div>
				</section>
				</cfif>
	    	</div>
	
	    	<!--- Sidebar --->
	    	<cfif args.sidebar and !cb.isHomePage()>
				<div class="col-sm-3 sidenav">
					#cb.quickView( view='_pagesidebar' )#
				</div>
	    	</cfif>
		</div>
	</section>
</cfif>

<!--- ContentBoxEvent --->
#cb.event("cbui_postPageDisplay")#

<!--- Custom JS --->
<!---<script type="text/javascript">
	$(document).ready(function() {
		<cfif cb.isCommentFormError()>
			toggleCommentForm();
		</cfif>
	});
	function toggleCommentForm(){
		$("##commentForm").slideToggle();
	}
</script>--->
</cfoutput>