<cfoutput>
<cfset prc.headerMainNav = cb.themeSetting( 'headerMainNav', 'none' )>
<cfset prc.sliderCategory = html.slugify( cb.themeSetting( 'sliderCategory', 'none' ) )>
<header>
	<div class="row-fixed">
		<div class="container">
			<div class="col-md-3">
				<div class="title">
					<cfif cb.themeSetting( 'headerLogo', '' ) is "">
						<h1>
							<a href="#cb.linkHome()#" class="navbar-brand" title="#cb.siteTagLine()#" data-toggle="tooltip"><strong>#cb.siteName()#</strong></a>
						</h1>
					<cfelse>
						<h1 class="brand-h1-img">
							<a href="#cb.linkHome()#" class="navbar-brand brand-img" title="#cb.siteTagLine()#" data-toggle="tooltip"><img src="#cb.themeSetting( 'headerLogo' )#" alt="#cb.siteName()#"></a>
						</h1>
					</cfif>
				</div><!--- end title --->
			</div>
			<div class="col-md-9">
				<nav class="navbar" id="nav-main">
					<div class="navbar-header" >
						<button type="button" id="cb-navbar-toggle" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##cb-nav-collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>		
					</div>
				
					<!--- Generate Menu --->
					<div class="collapse navbar-collapse" id="cb-nav-collapse">
						<cfif prc.headerMainNav is "none">
							<ul class="nav navbar-nav">
								<cfset menuData = cb.rootMenu( type="data", levels="2" )>
					
								<!--- Iterate and build pages --->
								<cfloop array="#menuData#" index="menuItem">
									<cfif structKeyExists( menuItem, "subPageMenu" )>
										<li class="dropdown">
											<a href="#menuItem.link#" class="dropdown-toggle" data-toggle="dropdown">#menuItem.title# <b class="caret"></b></a>
											#buildSubMenu( menuItem.subPageMenu )#
										</li>
									<cfelse>
										<cfif cb.isPageView() AND event.buildLink( cb.getCurrentPage().getSlug() ) eq menuItem.link>
											<li class="active">
										<cfelse>
											<li>
										</cfif>
											<a href="#menuItem.link#">#menuItem.title#</a>
										</li>
									</cfif>
								</cfloop>
					
								<!--- Blog Link, verify active --->
								<cfif ( !prc.cbSettings.cb_site_disable_blog )>
									<cfif cb.isBlogView()>
										<li class="active">
									<cfelse>
										<li>
									</cfif>
									<a href="#cb.linkBlog()#">Blog</a>
									</li>
								</cfif>
							</ul>
						<cfelse>
							#cb.menu( prc.headerMainNav )#
						</cfif>
					</div>
				</nav>
			</div>
		</div>
	</div>
	<div class="row">
		<cfif cb.isHomePage()>
			<!--- Slider --->
			<cfif prc.sliderCategory is not "none">
				<div id="home-slider">
					#cb.widget( name='ContentStoreSlider',args={max=3,category=prc.sliderCategory} )#
				</div>
			</cfif>
		<cfelseif cb.isPageView() or cb.isEntryView()>
			<cfif cb.isPageView()>
				<cfset content = prc.page>
			<cfelseif cb.isEntryView()>
				<cfset content = prc.entry>
			</cfif>
			<!--- Title --->
			<div style="background-image:url( #content.getFeaturedImageURL()#)">
				<div class="container title-container">
					<h1>#content.getTitle()#</h1>
					<div class="text-divider5">
						#content.getExcerpt()#
					</div>
				</div>
			</div>
		</cfif>
	</div>
	<div class="row">
		<div class="container">
			<div class="col-md-6">
				<cfif cb.themeSetting( 'locPhone', '' ) is not "">
					<div class="phone-header">
						<span>#cb.themeSetting( 'locPhone' )#</span>
					</div>
				</cfif>
			</div>
			<div class="col-md-6">
				<div class="social">
					<cfif cb.themeSetting( 'socialFB', '' ) is not "">
						<span class="fa-stack fa-1x">
							<a href="#cb.themeSetting( 'socialFB' )#">
								<span class="sr-only">Visit our Facebook page</span>
								<span class="fa fa-circle fa-stack-2x"></span>
								<span class="fa fa-facebook fa-stack-1x textWhite"></span>
							</a>
						</span>
					</cfif>
					<cfif cb.themeSetting( 'socialT', '' ) is not "">
						<span class="fa-stack fa-1x">
							<a href="#cb.themeSetting( 'socialT' )#">
								<span class="sr-only">Twitter</span>
								<span class="fa fa-circle fa-stack-2x"></span>
								<span class="fa fa-twitter fa-stack-1x textWhite"></span>
							</a>
						</span>
					</cfif>
					<cfif cb.themeSetting( 'socialGP', '' ) is not "">
						<span class="fa-stack fa-1x">
							<a href="#cb.themeSetting( 'socialGP' )#">
								<span class="sr-only">Google+</span>
								<span class="fa fa-circle fa-stack-2x"></span>
								<span class="fa fa-google-plus fa-stack-1x textWhite"></span>
							</a>
						</span>
					</cfif>
					<cfif cb.themeSetting( 'socialIG', '' ) is not "">
						<span class="fa-stack fa-1x">
							<a href="#cb.themeSetting( 'socialIG' )#">
								<span class="sr-only">Instagram</span>
								<span class="fa fa-circle fa-stack-2x"></span>
								<span class="fa fa-instagram fa-stack-1x textWhite"></span>
							</a>					
						</span>
					</cfif>
					<cfif cb.themeSetting( 'socialYT', '' ) is not "">
						<span class="fa-stack fa-1x">
							<a href="#cb.themeSetting( 'socialYT' )#">
								<span class="sr-only">YouTube</span>
								<span class="fa fa-circle fa-stack-2x"></span>
								<span class="fa fa-youtube fa-stack-1x textWhite"></span>
							</a>					
						</span>
					</cfif>
				</div>
			</div>
		</div>
	</div>
	
	<!--- Search Bar 
	<div id="body-search">
		<div class="container">
			<form id="searchForm" name="searchForm" method="post" action="#cb.linkContentSearch()#">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Enter search terms..." name="q" id="q" value="#cb.getSearchTerm()#">
					<span class="input-group-btn">
						<button type="submit" class="btn btn-default">Search</button>
					</span>
				</div>
			</form>
		</div>
	</div>--->
</header>
<cfscript>
any function buildSubMenu( required menuData ){
	var menu = '<ul class="dropdown-menu">';
	for( var menuItem in arguments.menuData ){
		if( !structKeyExists( menuItem, "subPageMenu" ) ){
			menu &= '<li><a href="#menuItem.link#">#menuItem.title#</a></li>';
		} else {
			menu &= '<li class="dropdown-submenu"><a href="#menuItem.link#" class="dropdown-toggle" data-toggle="dropdown">#menuItem.title#</a>';
			menu &= buildSubMenu( menuItem.subPageMenu );
			menu &= '</li>';
		}
	}
	menu &= '</ul>';

	return menu;
}
</cfscript>
</cfoutput>