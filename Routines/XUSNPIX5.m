XUSNPIX5 ;OAK_BP/CMW - NPI EXTRACT REPORT ;7/7/08  17:45
 ;;8.0;KERNEL;**453,481,548**; Jul 10, 1995;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; NPI Extract Report Mailer routine
 ;
 ; Input parameter: XUSRTN
 ;
 ; Other relevant variables:
 ;   XUSRTN="XUSNPIX1" (current routine name, used for ^XTMP and ^TMP
 ;                         storage subscript)
 ; Storage Global:
 ;   ^XTMP("XUSNPIX1",0) = Piece 1^Piece 2^Piece 3^Piece 4^Piece 5^Piece 6
 ;      where:
 ;      Piece 1 => Purge Date - 1 year in future
 ;      Piece 2 => Create Date - Today
 ;      Piece 3 => Description
 ;      Piece 4 => Last Date Compiled
 ;      Piece 5 => $H last run start time
 ;      Piece 6 => $H last run completion time
 ;
 ;   ^XTMP("XUSNPIX1",1) = DATA
 ;               
 ;          XUSNPI => Unique NPI of entry
 ;          LDT => Last Date Run, VA Fileman Format
 ;
 Q
 ;
EMAIL(XUSRTN) ; EMAIL THE MESSAGE
 ; Add domain name if it does not exist
 N XUSFOC,DLAYGO,DA,DIC,DIE,DR,X,Y
 I '$$FIND1^DIC(4.2,,"QX","Q-NPS.VA.GOV","B") D
 . S XUSFOC=$O(^DIC(4.2,"B","FOC-AUSTIN.VA.GOV",0)) I 'XUSFOC Q
 . I XUSFOC=$O(^DIC(4.2,"B","FOC-AUSTIN.VA.GOV",""),-1) D
 . . S DIC="^DIC(4.2,",X="Q-NPS.VA.GOV",DIC(0)="L",DLAYGO=4.2 D ^DIC K DLAYGO
 . . S DIE=DIC,DA=+Y
 . . S DR="1///NS;2///^S X=XUSFOC;1.7///YES;6.2///NPS;"
 . . D ^DIE
 ;
 N XMY
 ; Send email to designated recipient for live release
 D MAILTO^XUSNPIX1(.XMY) ;p548
 D ESEND
 Q
 ;
SMAIL(XUSRTN,XUSPROD,XUSVER,DTTM) ; Summary email
 N HYPHEN,L,M,N,T,TMP,T1,T2,T1NV,T2NV,XMY
 K ^TMP(XUSRTN,$J)
 S T1=$G(^XTMP(XUSRTN,1))
 S T2=$G(^XTMP(XUSRTN,2))
 S T1NV=$G(^XTMP(XUSRTN,"1NV"))
 S T2NV=$G(^XTMP(XUSRTN,"2NV"))
 S ^TMP(XUSRTN,$J,1)="SUMMARY"
 S ^TMP(XUSRTN,$J,2)="-------"
 S ^TMP(XUSRTN,$J,3)=^XTMP(XUSRTN,"H")_"  "_DTTM
 S ^TMP(XUSRTN,$J,4)=""
 S ^TMP(XUSRTN,$J,5)="Type 1  NEW PERSON FILE (#200)          "_$J(+$P(T1,U),3)_" Message(s) Totaling "_$J(+$P(T1,U,2),7)_" NPI records."
 S ^TMP(XUSRTN,$J,6)="Type 2  INSITUTION FILE (#4)            "_$J(+$P(T2,U),3)_" Message(s) Totaling "_$J(+$P(T2,U,2),7)_" NPI records."
 S ^TMP(XUSRTN,$J,7)="Type 1  NON VA Individual (#355.93)     "_$J(+$P(T1NV,U),3)_" Message(s) Totaling "_$J(+$P(T1NV,U,2),7)_" NPI records."
 S ^TMP(XUSRTN,$J,8)="Type 2  NON VA Facility/Group (#355.93) "_$J(+$P(T2NV,U),3)_" Message(s) Totaling "_$J(+$P(T2NV,U,2),7)_" NPI records."
 S ^TMP(XUSRTN,$J,9)=""
 S ^TMP(XUSRTN,$J,10)="Programmer Notes:   "_XUSVER_" - "_$G(XUSPROD)
 ;
 ;Summary Detail
 ;
 S HYPHEN="",$P(HYPHEN,"-",84)="-"
 ;
 S ^TMP(XUSRTN,$J,11)=""
 S ^TMP(XUSRTN,$J,12)=HYPHEN
 S ^TMP(XUSRTN,$J,13)=""
 S ^TMP(XUSRTN,$J,14)="MESSAGE DETAILS"
 S ^TMP(XUSRTN,$J,15)="---------------"
 S ^TMP(XUSRTN,$J,16)=""
 S ^TMP(XUSRTN,$J,17)="TYPE      "_$J("MESSAGE NUMBER",20)_$J("RECORD COUNT",20)
 S ^TMP(XUSRTN,$J,18)="----------"_$J("--------------",20)_$J("------------",20)
 ;
 S L=18,T="" F  S T=$O(^TMP("XUSNPIXS",$J,T)) Q:'T  S M=0 F  S M=$O(^TMP("XUSNPIXS",$J,T,M)) Q:'M  D
 .S N=$G(^TMP("XUSNPIXS",$J,T,M))
 .S L=L+1
 .S ^TMP(XUSRTN,$J,L)=$E($P(N,U)_"          ",1,10)_$J(M,16)_$J($P(N,U,2),24)
 S L=L+1,^TMP(XUSRTN,$J,L)=""
 S L=L+1,^TMP(XUSRTN,$J,L)=HYPHEN
 ; Send verification email to local mail group and VA Outlook mail group
 S XMY("G.NPI EXTRACT VERIFICATION")=""
 N XMTEXT,XMSUB,XMDUN,XMDUZ,XMZ,XMMG,DIFROM
 S XMTEXT="^TMP("""_XUSRTN_""","_$J_","
 S XMSUB=$TR($P(^XTMP(XUSRTN,"H"),U),":")_"("_$G(XUSPROD)_") NPI CROSSWALK EXTRACT SUMMARY "
 D ^XMD
 K ^TMP(XUSRTN,$J)
 Q
 ;
ESEND N XMTEXT,XMSUB,XMDUN,XMDUZ,XMZ,XMMG,DIFROM
 S XMTEXT="^TMP("""_XUSRTN_""","_$J_","
 S XMSUB=$TR($P($G(^TMP(XUSRTN,$J,1)),U),":")_"("_$G(XUSPROD)_") NPI EXTRACT TYPE 1 "
 D ^XMD
 Q
