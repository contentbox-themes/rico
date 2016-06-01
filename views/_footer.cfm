<cfoutput>				
<footer id="footer">
	 <!--- contentboxEvent --->
	 #cb.event( "cbui_footer" )#
	 <div id="copyright">
		<div class="container">
			<div class="col-md-4">
				<p class="">Copyright &copy; #cb.siteName()#.  All rights reserved.</p>
				<p class="">Powered by ContentBox v#cb.getContentBoxVersion()#</p>
			</div>
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<cfif cb.themeSetting( 'locAddress', '' ) is not "">
					<div class="address-footer">
						<span>#cb.themeSetting( 'locAddress' )#</span><br/>
						<span>#cb.themeSetting( 'locCity' )#</span>, <span>#cb.themeSetting( 'locState' )#</span> <span>#cb.themeSetting( 'locZip' )#</span>
					</div>
				</cfif>
				<cfif cb.themeSetting( 'locPhone', '' ) is not "">
					<div class="phone-footer">
						<span><strong>Phone:</strong> #cb.themeSetting( 'locPhone' )#</span>
					</div>
				</cfif>
				<cfif cb.themeSetting( 'locEmail', '' ) is not "">
					<div class="email-footer">
						<span><strong>E-mail:</strong> <a href="mailto:#cb.themeSetting( 'locEmail' )#">#cb.themeSetting( 'locEmail' )#</a></span>
					</div>
				</cfif>
			</div>
		</div>
	</div>
</footer>
</cfoutput>