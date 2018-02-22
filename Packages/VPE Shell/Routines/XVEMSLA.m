XVEMSLA ;DJB/VSHL**VA KERNEL Library Functions - Dates [8/18/95 1:30pm];2017-08-15  5:03 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DATE ;;;
 ;;; DATE FUNCTIONS - XLFDT
 ;;;
 ;;; HTFM(x,y)......%H to Fileman
 ;;;      x = $H date (in quotes)
 ;;;      y = 1 (optional) to return date portion only (no seconds)
 ;;;      Ex: W $$HTFM^XLFDT("54786,40523",1)  --> 2901231
 ;;;
 ;;; FMTH(x,y)......Fileman to $H
 ;;;      x = Fileman date
 ;;;      y = 1 (Optional) no seconds.
 ;;;      Ex: W $$FMTH^XLFDT(2901231.111523)   --> 54786,40523
 ;;;
 ;;; HTE(x,y)......$H to External
 ;;;      x = $H date (in quotes)
 ;;;      y = See FMTE(x,y) for alternate values
 ;;;      Ex: W $$HTE^XLFDT("54786,40523")   --> Dec 31, 1990@11:15:23
 ;;;
 ;;; FMTE(x,y)......Fileman to External
 ;;;      x = VA Fileman date
 ;;;      y = optional - if null ('$D(y)) return written-out format
 ;;;         if +y=1 return written-out format
 ;;;         if +y=2 return in MM/DD/YY@HH:MM:SS format
 ;;;         if +y=3 return in DD/MM/YY@HH:MM:SS format
 ;;;         if +y=4 return in YY/MM/DD@HH:MM:SS format
 ;;;         if y contains S return seconds
 ;;;         if y contains D return date portion only
 ;;;         if y contains P return in HH:MM:SS am/pm format
 ;;;      Ex: W $$FMTE^XLFDT(2901231.111523,1)  --> Dec 31, 1990@11:15:23
 ;;;          W $$FMTE^XLFDT(2901231.1115,"4D") --> 90/02/31
 ;;;
 ;;; DOW(x,y)......Day-of-Week
 ;;;      x = VA Fileman date
 ;;;      y = 1 (optional) to return day-of-week number
 ;;;      Ex: W $$DOW^XLFDT(2901231.111523)     --> Monday
 ;;;
 ;;; HDIFF(x1,x2,x3)....$H Differences
 ;;;      To calculate the difference between 2 dates in $H format.
 ;;;      x1 = $H date (in quotes)
 ;;;      x2 = $H date, to subtract from the x1 date
 ;;;      x3 = see FMDIFF(x1,x2,x3) for alternative values
 ;;;
 ;;; FMDIFF(x1,x2,x3)....Fileman Difference
 ;;;      To calculate the difference between 2 dates in VA Fileman format.
 ;;;      x1 = VA Fileman date
 ;;;      x2 = VA Fileman date to subtract from x1 date
 ;;;      x3 = optional - if null return difference in days
 ;;;          if x3=1 return difference in days (x1-x2)
 ;;;          if x3=2 return difference in seconds
 ;;;          if x3=3 return difference in DD HH:MM:SS format
 ;;;      Ex: W $$FMDIFF^XLFDT(2901229,2901231.111523,1)   --> -2
 ;;;          The 1st date is 2 days less than the 2nd date
 ;;;          W $$FMDIFF^XLFDT(2901231.111523,2901229.173404,2)  --> 150079
 ;;;          The 1st date is 150079 seconds greater than the 2nd date
 ;;;
 ;;; HADD(x,d,h,m,s)....$H Add
 ;;;      To add days,hours,minutes, & seconds to a date in $H format (to x).
 ;;;      x = $H date (in quotes)
 ;;;      d = days
 ;;;      h = hours
 ;;;      m = minutes
 ;;;      s = seconds
 ;;;      Ex: W $$HADD^XLFDT("54786,3600",2,2,20,15)  --> 54788,12015
 ;;;
 ;;; FMADD(x,d,h,m,s)...Fileman Add
 ;;;      Add days,hours,minutes, & seconds to a date in VA Fileman format (to x).
 ;;;      x = VA Fileman date
 ;;;      d,h,m,s same as HADD above
 ;;;      Ex: W $$FMADD^XLFDT(2901231.01,2,2,20,15)  --> 2910102.032015
 ;;;
 ;;; NOW()...Current date/time in Fileman format
 ;;;      Ex: W $$NOW^XLFDT  --> 2921009.08425
 ;;;
 ;;; DT()....Current date in Fileman format
 ;;;      Ex: W $$DT^XLFDT  --> 2921009
 ;;;***
