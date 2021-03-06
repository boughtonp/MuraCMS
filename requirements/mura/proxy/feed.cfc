<cfcomponent output="false" extends="service">

<cffunction name="getBean" output="false">
	<cfargument name="event">
	
	<cfset var feed="">
	
	<cfif len(event.getValue("feedID"))>
		<cfset feed=application.feedManager.read(event.getValue("feedID"),event.getValue("siteid"))>
	<cfelseif len(event.getValue("name"))>
		<cfset feed=application.feedManager.readByName(event.getValue("name"),event.getValue("siteid"))>
	</cfif>
	
	<cfset event.setValue('feed',removeObjects(feed.getAllValues()))>
	
	<cfreturn feed>
	
</cffunction>

<cffunction name="getFeed" output="false">
	<cfargument name="event">
		<cfset var feed = getBean(event)>
		<cfif not application.feedManager.allowFeed(feedBean=feed,userID=session.mura.userID) >
			<cfset event.setValue("__response__", "access denied")>
		<cfelse>
			<cfset event.setValue("__response__", feed.getQuery())>
		</cfif>
</cffunction>

</cfcomponent>