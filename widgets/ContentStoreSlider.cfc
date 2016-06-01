/**
* ContentBox - A Modular Content Platform
* Copyright since 2012 by Ortus Solutions, Corp
* www.ortussolutions.com/products/contentbox
* ---
* A widget that renders a preview of a ContentStore's category, which is displayed in a as a slideshow.
*/
component extends="contentbox.models.ui.BaseWidget" singleton{

	ContentStoreSlider function init(){
		// Widget Properties
		setName( "ContentStoreSlider" );
		setVersion( "1.0" );
		setDescription( "A widget that renders a preview of a ContentStore's category, which is displayed as a slideshow." );
		setAuthor( "Ortus Solutions" );
		setAuthorURL( "http://www.ortussolutions.com" );
		setIcon( "hdd-o" );
		setCategory( "Content" );

		return this;
	}

	/**
	* Renders a published ContentStore object, if no default value is used, this throws an exception
	* @max.hint The maximum number of records to paginate
	* @titleLevel.hint The H{level} to use, by default we use H2
	* @category.hint The category to filter the content on
	*/
	any function renderIt( 
		numeric max=3,
		string titleLevel="2", 
		string category="" 
	){
		var contentResults 	= contentStoreService.findPublishedContent( max=arguments.max, category=arguments.category );
		var rString			= "";
		var tempPath 		= "";
		var tempTitle 		= "";
		var tempLink 		= "";
		var tempLinkText	= "";
		var activeClass		= "";
		
		if( contentResults.count ){
			
			// iteration cap
			if( contentResults.count lt arguments.max){
				arguments.max = contentResults.count;
			}

			// generate
			saveContent variable="rString"{
				include "contentstoreslider-templates/default.cfm";
			}
		}
		return rString;
	}
}
