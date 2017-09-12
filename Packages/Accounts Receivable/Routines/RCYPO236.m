RCYPO236 ;MAF/ALB - POST INIT FOR POPULATING THE EMERGENCY FIELDS FOR BEGINNING AND ENDING DATES ;9/20/05
V ;;4.5;Accounts Receivable;**236**;Mar 20, 1995
 D BMES^XPDUTL(">>>>>>>Updating the beginning and ending dates for the")
 D BMES^XPDUTL("       Katrina Emergency Response patch<<<<<<<")
 S $P(^RC(342,1,30),"^",1)=3050901
 S $P(^RC(342,1,30),"^",2)=3060228
 D BMES^XPDUTL(">>Done")
 Q
