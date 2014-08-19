<!--- validatePassword(fname=,lname=,email,company=,phone=,passwordIn=,[passwordInMatch=,]) --->
	<cffunction name="validatePassword" access="private" returntype="array" hint="I check password strength and determine if it is up to snuff, I return an array of error messages">
	<!--- Accept username arg for comparing later in the function --->
	<cfargument name="fname" required="true" type="string" hint="Send in firstname as string">
	<cfargument name="lname" required="true" type="string" hint="Send in lastname as string">
	<cfargument name="email" required="true" type="string" hint="Send in email as string">
	<cfargument name="company" required="true" type="string" hint="Send in company as string">
	<cfargument name="phone" required="true" type="string" hint="Send in firstname as string">
	<!--- Accept password argument, default to blank string should be ok cause it will fail all of the tests --->
	<cfargument name="passwordIn" required="true"  type="string" hint="Send in password as a string">
	<cfargument name="passwordInMatch" required="false" type="string" hint="Send in password matching field [optional]">
	
	<!--- Initialize return variable --->
	<cfset var aErrors = ArrayNew(1) />
	
	<!--- If the password is more than X and less than Y, add an error. You could make this two functions (one for the lower limit and one for the upper), but why bother, can your users count? --->
	<cfif Len(arguments.passwordIn) LT 8 OR Len(arguments.passwordIn) GT 25>
			<cfset ArrayAppend(aErrors, "Your password must be between 8 and 25 characters long") />
	</cfif>
	
	<!--- we have a verification field to validate as well --->
	<cfif structkeyexists(arguments,"passwordInMatch")>
		<cfif len(arguments.passwordIn) neq len(arguments.passwordInMatch) OR find(arguments.passwordInMatch,arguments.passwordIn) lte 0>
			<cfset ArrayAppend(aErrors, "Your passwords do not match") />
		</cfif>
	</cfif>
	<!--- Check for atleast 1 uppercase letter --->
	<cfif NOT REFind('[A-Z]+', arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password must contain at least 1 uppercase letter") />
		</cfif>
	
	<!--- Check for atleast 1 lowercase letter --->
	<cfif NOT REFind('[a-z]+', arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password must contain at least 1 lowercase letter") />
		</cfif>
	
	<!--- Check for atleast 1 numeral --->
	<cfif NOT REFind('[0-9]+', arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password must contain at least 1 numeral") />
		</cfif>
	
	<!--- Check for one of the predfined special characters, you can add more by seperating each character with a pipe(|) --->
	<!---<cfif NOT REFind("[^\w\d\s]+", arguments.passwordIn)>--->
	<cfif NOT REFind("[;:@!$##%^&*()_\-+='\\\|{}?/,.]", arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password must contain at least 1 of the following special characters [;:@!$##%^&*()_\-+='\\\|{}?/,.] ") />
	</cfif>
	
	<!--- Check to see if the password contains the firstname --->
	<cfif findNoCase(arguments.fname, arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password cannot contain your first name") />
	</cfif>
	
	<!--- Check to see if the password contains the lastname --->
	<cfif findNoCase(arguments.lname, arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password cannot contain your last name") />
	</cfif>
	
	<!--- Check to see if the password contains the email --->
	<cfif findNoCase(arguments.email, arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password cannot contain your email") />
	</cfif>
	
	<!--- Check to see if the password contains the phone --->
	<cfif findNoCase(arguments.phone, arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password cannot contain your phone number") />
	</cfif>
	
	<!--- Check to see if the password contains the company --->
	<cfif findNoCase(arguments.company, arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password cannot contain your company name") />
	</cfif>
	
	<!--- Make sure password contains no spaces --->
	<cfif arguments.passwordIn CONTAINS " ">
			<cfset ArrayAppend(aErrors, "Your password cannot contain spaces") />
		</cfif>
	
	<!--- Make sure password is not a date
	<cfif IsDate(arguments.passwordIn)>
			<cfset ArrayAppend(aErrors, "Your password cannot be a date") />
		</cfif> --->
	
	<!--- return the array of errors. On the other end you can do a check of <cfif ArrayLen(aErrors) EQ true>There are errors</cfif> --->
	<cfreturn aErrors />
</cffunction>
