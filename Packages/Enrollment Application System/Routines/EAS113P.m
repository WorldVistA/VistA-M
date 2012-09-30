EAS113P ;ALB/CKN - EAS MT LETTERS POST INSTALL ROUTINE ; 11/21/02 3:45pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**13**;MAR 15,2001
 Q
EP ;
 N DIE,DA,DR,IEN0,IEN30,IEN60,TEXT,FILE,K,WP0,WP30,WP60,WP,XIEN
 ;Update EAS MT LETTERS file (#713.3)
 D MES^XPDUTL("*** Updating EAS MT LETTERS file(#713.3)***")
 S FILE=713.3
 D MES^XPDUTL("*** Updating 0-DAY LETTER ***")
 S IEN0=$O(^EAS(713.3,"B","0-DAY LETTER",""))
 I IEN0="" D MES^XPDUTL("*** 0-DAY LETTER not updated ***")
 I IEN0'="" D
 . S DIE="^EAS(713.3,",DA=IEN0,DR="3///@" D ^DIE K DIE,DA
 . K WP0
 . F K=1:1 S TEXT=$P($T(DAY0+K),";;",2) Q:TEXT="EXIT"  S WP0(K)=TEXT
 . D FILE(IEN0,.WP0)
 D MES^XPDUTL("*** Updating 30-DAY LETTER ***")
 S IEN30=$O(^EAS(713.3,"B","30-DAY LETTER",""))
 I IEN30="" D MES^XPDUTL("*** 30-DAY LETTER not updated ***")
 I IEN30'="" D
 . S DIE="^EAS(713.3,",DA=IEN30,DR="3///@" D ^DIE K DIE,DA
 . K WP30
 . F K=1:1 S TEXT=$P($T(DAY30+K),";;",2) Q:TEXT="EXIT"  S WP30(K)=TEXT
 . D FILE(IEN30,.WP30)
 D MES^XPDUTL("*** Updating 60-DAY LETTER ***")
 S IEN60=$O(^EAS(713.3,"B","60-DAY LETTER",""))
 I IEN60="" D MES^XPDUTL("*** 60-DAY LETTER not updated ***")
 I IEN60'="" D
 . S DIE="^EAS(713.3,",DA=IEN60,DR="3///@" D ^DIE K DIE,DA
 . K WP60
 . F K=1:1 S TEXT=$P($T(DAY60+K),";;",2) Q:TEXT="EXIT"  S WP60(K)=TEXT
 . D FILE(IEN60,.WP60)
 Q
FILE(XIEN,WP) ;
 D WP^DIE(FILE,XIEN,3,,"WP","ERR")
 K WP
 Q
DAY0 ;;
 ;;According to our records you have not responded to our previous requests
 ;;to complete the financial section of VA Form 10-10EZ, Application for
 ;;Health Benefits.  This is to inform you that your current financial
 ;;assessment (means test) has expired.
 ;; 
 ;;How Does This Affect Your Eligibility for Care?
 ;;  o We do not have a current means test for you on file, which is
 ;;    needed to determine your continued eligibility for care of your
 ;;    non-service connected conditions.
 ;;  o We are unable to schedule you for future care of your non-service
 ;;    connected conditions.
 ;; 
 ;;How Does This Affect Your Enrollment?
 ;;  o We are unable to determine your priority for enrollment in the VA
 ;;    health care system.
 ;; 
 ;;What Do You Need To Do?
 ;;  o Complete, sign and return a new VA Form 10-10EZ, including the
 ;;    financial section.
 ;;  o Read the enclosed VA Form 4107, Notice of Procedural and Appellate
 ;;    Rights. If you disagree with our decision, you or your representative
 ;;    may complete a Notice of Disagreement and return it to the Enrollment
 ;;    Coordinator or Health Benefits Advisor at your local VA health care
 ;;    facility.
 ;; 
 ;;What If You Have Questions?
 ;;EXIT
DAY30 ;;
 ;;Each year the VA requires non-service connected veterans and 0% service 
 ;;connected veterans to complete a financial assessment (means test).  Our
 ;;records show that your annual means test is due |ANNVDT|.
 ;; 
 ;;As of this date we have not received the updated financial income
 ;;information we requested in a previous letter.
 ;; 
 ;;What Does This Mean To You?
 ;;  o Your updated financial assessment information is needed to determine
 ;;    your continued eligibility for care of your non-service connected
 ;;    conditions.
 ;;  o Failure to complete the means test by the anniversary date will
 ;;    prevent us from being able to schedule you for future care for
 ;;    your non-service connected conditions.
 ;; 
 ;;What Do You Need To Do?
 ;;  o Complete and sign the enclosed Financial Assessment portion of the
 ;;    enclosed VA Form 10-10EZ, Application for Health Benefits, reporting
 ;;    income and assets for the previous calendar year.
 ;;  o Return the completed and signed form in the enclosed envelope before
 ;;    your means test anniversary date. 
 ;;  o When you report to your next health care appointment, bring your
 ;;    health insurance card so we may update your health insurance
 ;;    information. 
 ;;  o Notify us if you feel you received this letter in error
 ;; 
 ;;What If You Have Questions?
 ;;EXIT
DAY60 ;;
 ;;Each year the VA requires non-service connected veterans and 0% service 
 ;;connected veterans to complete a financial assessment (means test).  Our
 ;;records show that your annual means test is due |ANNVDT|.
 ;; 
 ;;What Does This Mean To You?
 ;;  o Your financial assessment information is used to determine your
 ;;    continued eligibility for care of your non-service connected
 ;;    conditions.
 ;;  o Failure to complete the means test by the anniversary date will
 ;;    prevent us from being able to schedule you for future care for
 ;;    your non-service connected conditions.
 ;; 
 ;;What Do You Need To Do?
 ;;  o Complete and sign the Financial Assessment portion of the enclosed VA
 ;;    Form 10-10EZ, Application for Health Benefits, reporting income and
 ;;    assets for the previous calendar year.
 ;;  o Return the completed and signed form in the enclosed envelope before
 ;;    your means test anniversary date.
 ;;  o When you report to your next health care appointment, bring your
 ;;    health insurance card so we may update your health insurance
 ;;    information.
 ;;  o Notify us if you feel you received this letter in error. 
 ;; 
 ;;What If You Have Questions?
 ;;EXIT
