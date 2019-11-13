PRCA355E ;ALB/JSG - PATCH PRCA*4.5*355 ENVIRONMENT CHECKING ROUTINE ;5/28/19 6:22pm
 ;;4.5;Accounts Receivable;**355**;Mar 20, 1995;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ENV ; "Environment" checking
 N STDY
 ;
 S XPDNOQUE=1   ; don't allow anyone to queue the install no matter what they say.
 ;
 ; Get the statement day
 S STDY=$$GETDOM
 ;
 ; due to monthly statement processing, only allowed to install this patch on certain days each month.
 I STDY>0,'$$ALLOWED(DT) D  ; Site is one of the 16 sites listed below and is not allowed to install on this day
 . S XPDQUIT=1
 . W !,"** Installation of PRCA*4.5*355 is not allowed into your production account on today's date **"
 . W !,"Please re-attempt on any day of the month other than the period from days 17 through 28 inclusive.",!
 E  D
 . W !,"Installation of PRCA*4.5*355 is allowed.",!
 Q
 ;
ALLOWED(DATE) ; Allow installation outside of the inclusive period of days 17-28
 ;
 ; Input:   Date in VistA/FileMan format
 ;
 ; Output:  Flg - 1 (Allow installation) or
 ;                0 (Do not allow installation)
 ;
 N DAY
 ; Get today's day of the month
 S DAY=$E(DATE,$L(DATE)-1,$L(DATE))
 ; 
 ; Installation allowed on days outside the period of days 17-28 inclusive
 Q $S(DAY<17:1,DAY>28:1,1:0)
 ;
GETDOM() ; Get site and statement day
 ; Input:  None
 ;
 ; Output:  New statement day or flag
 ;     0 - Flag for sites that do not need to get new statement day
 ;    26 - New statement day for 10 selected sites
 ;    28 - New statement day for 6 selected sites
 ;
 N FLG,SITE,SITES26,SITES28
 S SITE=+$$SITE^VASITE
 S SITES26=$P($T(SITES26),";",3)
 S SITES28=$P($T(SITES28),";",3)
 S FLG=$S(SITES26[(","_SITE_","):26,SITES28[(","_SITE_","):28,1:0)
 Q FLG
 ;
 ; From PRCA*4.5*355 Patch Description:
 ;
 ; Sites with new statement day = 26
SITES26 ;;,438,501,504,542,562,568,649,656,688,756,
 ;
 ; Sites with new statement day = 28
SITES28 ;;,565,621,658,664,671,740,
