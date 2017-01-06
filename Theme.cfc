/**
* ContentBox - A Modular Content Platform
* Copyright since 2012 by Ortus Solutions, Corp
* www.ortussolutions.com/products/contentbox
* ---
* A theme is composed of the following pieces
* 
* /ThemeDirectory
*  + Theme.cfc (The CFC that models your theme implementation)
*  / layouts (The folder that contains layouts in your theme)
*    + blog.cfm (Mandatory layout used for all blog views by convention)
*    + pages.cfm (Mandatory layout used for all pages by convention)
*    + maintenance.cfm (Optional used when in maintenance mode, else defaults to pages)
*    + search.cfm (Optional used when doing searches, else defaults to pages)
*  / views (The folder that contains views for rendering)
*  	 + archives.cfm (MANDATORY: The view used to render out blog archives.)
*  	 + entry.cfm (MANDATORY: The view used to render out a single blog entry with comments, etc.)
*  	 + error.cfm (MANDATORY: The view used to display errors when they ocurr in your blog or pages)
*  	 + index.cfm (MANDATORY: The view used to render out the home page where all blog entries are rendered)
*  	 + notfound.cfm (The view used to display messages to users when a blog entry requested was not found in our system.)
*  	 + page.cfm (MANDATORY: The view used to render out individual pages.)
*  	 + maintenance.cfm (OPTIONAL: Used when in maintenance mode)
* / templates (The folder that contains optional templates for collection rendering that are used using the quick rendering methods in the CB Helper)
* 	 + category.cfm (The template used to display an iteration of entry categories using coldbox collection rendering)
* 	 + comment.cfm (The template used to display an iteration of entry or page comments using coldbox collection rendering)
* 	 + entry.cfm (The template used to display an iteration of entries in the home page using coldbox collection rendering)
* / widgets (A folder that can contain layout specific widgets which override core ContentBox widgets)
* 
* Templates
* Templates are a single cfm template that is used by ContentBox to iterate over a collection (usually entries or categories or comments) and
* render out all of them in uniformity.  Please refer to ColdBox Collection Rendering for more information.  Each template recevies
* the following:
* 
* _counter (A variable created for you that tells you in which record we are currently looping on)
* _items (A variable created for you that tells you how many records exist in the collection)
* {templateName} The name of the object you will use to display: entry, comment, category
*
* Layout Local CallBack Functions:
* onActivation()
* onDelete()
* onDeactivation()
* 
* Settings
* You can declare settings for your layouts that ContentBox will manage for you.
* 
* this.settings = [
* 	{ name="Title", defaultValue="My Awesome Title", required="true", type="text", label="Title:" },
* 	{ name="Colors", defaultValue="blue", required="false", type="select", label="Color:", options="red,blue,orange,gray" }
* ];
* 
* The value is an array of structures with the following keys:
* 
* - name : The name of the setting (required), the setting is saved as cb_layoutname_settingName
* - defaultValue : The default value of the setting (required)
* - required : Whether the setting is required or not. Defaults to false
* - type : The type of the HTMl control (text=default, textarea, boolean, select)
* - label : The HTML label of the control (defaults to name)
* - title : The HTML title of the control (defaults to empty string)
* - options : The select box options. Can be a list or array of values or an array of name-value pair structures
* - group : lets you group inputs under a Group name - settings should be in order for groupings to work as expected
* - groupIntro : Lets you add a description for a group of fields
* - fieldDescription : Lets you add a description for an individual field
* - fieldHelp : Lets you add a chunk of HTML for a Modal, openable by the User by clicking on question mark next to the field label. Recommended use is to readFiles from the ./includes/help directory, with a helper function, for example: loadHelpFile( 'cbBootswatchTheme.html' ); 
*/
component{
 	
 	property name="settingService"	inject="id:settingService@cb";
 	property name="menuService" 	inject="id:MenuService@cb";
 	property name="categoryService" inject="id:CategoryService@cb";
 	property name="pageService" 	inject="id:PageService@cb";
 	 
	// Layout Variables
    this.name       	= "ContentBox Rico Theme";
	this.description 	= "ContentBox Rico layout for ContentBox 3 based on Bootstrap 3";
    this.version        = "@build.version@+@build.number@";
	this.author 		= "Ortus Solutions";
	this.authorURL		= "https://www.ortussolutions.com";
	// Screenshot URL, can be absolute or locally in your layout package.
	this.screenShotURL	= "screenshot.png";
	
	
	function onDIComplete( ){
		
		// Layout Settings
		this.settings = [
			{ name="cbBootswatchTheme", 	group="Colors", 	defaultValue="corporate", 	type="select", 	label="ContentBox Color Palette:", 	required="false", optionsUDF="getSwatches", groupIntro="Control the color scheme of your entire site by changing the color palette.", fieldHelp="#loadHelpFile( 'cbBootswatchTheme.html' )#"  },
			
			{ name="headerLogo", 			group="Header", 	defaultValue="", 			type="text", 	label="Logo URL:", groupIntro="Customize the header section of your theme.", 	fieldDescription="Enter a relative or full url for the website logo. Recommended dimensions: 300x50."  },
			{ name="headerMainNav", 		group="Header", 	defaultValue="none", 		type="select", 	label="Main Navigation:", optionsUDF="menus", fieldDescription="Select a menu for the Main Navigation."},
		
			{ name="sliderCategory", 		group="Slideshow", 	defaultValue="none", 		type="select", 	label="Content Category:", optionsUDF="entryCategories", groupIntro="Customize the slider that appears in the homepage.", fieldDescription="Select the content store category.", fieldHelp="#loadHelpFile( 'contentStoreSlider.html' )#" },
			
			{ name="hpArticleTitle", 		group="Homepage Article", 	defaultValue="", 		type="text", 		label="Homepage Article Title:", groupIntro="Add an article to the section below slider in homepage." },
			{ name="hpArticleText",			group="Homepage Article", 	defaultValue="", 		type="textarea", 	label="Homepage Article Text:" },
			{ name="hpArticleBtnText", 		group="Homepage Article", 	defaultValue="", 		type="text", 		label="Homepage Article Button Title:" },
			{ name="hpArticleBtnURL", 		group="Homepage Article", 	defaultValue="", 		type="text", 		label="Homepage Article Button URL:" },
			{ name="hpArticleImg", 			group="Homepage Article", 	defaultValue="", 		type="text", 		label="Homepage Article Image:" },
			
			{ name="secQuoteText",			group="Quote", 	defaultValue="", 		type="textarea", 	label="Quote Text:", groupIntro="Add quote to homepage." },
			{ name="secQuoteImgBg", 		group="Quote", 	defaultValue="", 		type="text", 		label="Quote Image Background:" },
			
			{ name="entriesTitle", 			group="Blog Entries", defaultValue="", 		type="text", 	label="Blog Entries Title:", groupIntro="Add blog feed to homepage." },
			{ name="entriesCategory",   	group="Blog Entries", defaultValue="none", 	type="select", 	label="Blog Entries Category:", optionsUDF="entryCategories" },
			
			{ name="csCategory", 			group="Content Store Entries", defaultValue="none", type="select", 		label="Content Store Category:", optionsUDF="entryCategories", groupIntro="Feature a Content Store category.", fieldDescription="Select the content store category.", fieldHelp="#loadHelpFile( 'contentStoreGrid.html' )#" },
			{ name="csBtnText", 			group="Content Store Entries", defaultValue="", 		type="text", 	label="Content Store Button Title:" },
			{ name="csBtnURL", 				group="Content Store Entries", defaultValue="", 		type="text", 	label="Content Store Button URL:" },
				
			{ name="rssDiscovery", 			group="Homepage", 	defaultValue="true", 	type="boolean",		label="Active RSS Discovery Links", 	required="false" },
			{ name="showCategoriesBlogSide", 	group="Blog Sidebar Options", defaultValue="true", type="boolean",		label="Show Categories in Blog Sidebar", 	required="false" },
			{ name="showRecentEntriesBlogSide", group="Blog Sidebar Options", defaultValue="true", type="boolean",	label="Show Recent Enties in Blog Sidebar", 	required="false" },
			{ name="showSiteUpdatesBlogSide", 	group="Blog Sidebar Options", defaultValue="true", type="boolean",	label="Show Site Updates in Blog Sidebar", 	required="false" },
			{ name="showEntryCommentsBlogSide", group="Blog Sidebar Options", defaultValue="true", type="boolean",	label="Show Entry Comments in Blog Sidebar", 	required="false" },
			{ name="showArchivesBlogSide", 		group="Blog Sidebar Options", defaultValue="true", type="boolean",	label="Show Archives in Blog Sidebar", 	required="false" },
			{ name="showEntriesSearchBlogSide", group="Blog Sidebar Options", defaultValue="true", type="boolean",	label="Show Entries Search in Blog Sidebar", 	required="false" },
			
			{ name="locAddress", 			group="Location", defaultValue="", 		type="text", 	label="Address:" },
			{ name="locCity", 				group="Location", defaultValue="", 		type="text", 	label="City:" },
			{ name="locState", 				group="Location", defaultValue="", 		type="text", 	label="State:" },
			{ name="locZip", 				group="Location", defaultValue="", 		type="text", 	label="Zip:" },
			{ name="locPhone", 				group="Location", defaultValue="", 		type="text", 	label="Phone:" },
			{ name="locEmail", 				group="Location", defaultValue="", 		type="text", 	label="Email:" },
		
			{ name="socialFB", 		group="Social", defaultValue="", 		type="text", 	label="Facebook:" },
			{ name="socialIG", 		group="Social", defaultValue="", 		type="text", 	label="Instagram:" },
			{ name="socialT", 		group="Social", defaultValue="", 		type="text", 	label="Twitter:" },
			{ name="socialGP", 		group="Social", defaultValue="", 		type="text", 	label="Google+:" },
			{ name="socialYT", 		group="Social", defaultValue="", 		type="text", 	label="YouTube:" }
			
		];
		return this;
	}
	
	/**
	* Build the swatches options
	*/
	array function getSwatches(){
		return listToArray( "corporate,teetime,green-blue,chocolate" );
	}
	
	/**
	* loadHelpFile - helper function for loading html help into a variable for modal
	* @helpFileName - the name of the file to read and return
	* @helpFilePath - the relative directory for the help files. Defaulting to ./includes/help/ inside the theme.
	* @return the contents of the file or empty string if the file does not exist
	*/
	function loadHelpFile( required string helpFileName, string helpFilePath='./includes/help/' ){
		try {
			return fileRead( arguments.helpFilePath & arguments.helpFileName );
		} catch( any e ){
			return '';
		}
	}
	
	/**
	* Call Back when layout is activated
	*/
	function onActivation(){
	
	}

	/**
	* Call Back when layout is deactivated
	*/
	function onDeactivation(){

	}

	/**
	* Call Back when layout is deleted from the system
	*/
	function onDelete(){

	}
	
	function cbadmin_postThemeSettingsSave(event, interceptData, buffer){
		
	}
		
	/**
	* Gets names of categories
	*/
	string function entryCategories() {
		var categoryList = arraytoList( categoryService.getAllNames() );
		categoryList = ListPrepend( categoryList, "none" );
		return categoryList;
	}
	
	/**
	* Gets all menu slugs
	*/
	string function menus() { 
		var menuList = arraytoList( menuService.getAllSlugs() );
		menuList = ListPrepend( menuList, "none" );
		return menuList;
	}
}
