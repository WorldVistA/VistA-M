IVMUM8 ;ALB/SEK - DELETE IVM MEANS TEST (CON'T) ; 13 JAN 94
 ;;2.0;INCOME VERIFICATION MATCH;**1,17**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; change demo data in 408.12 & 408.13 back to VAMC values
 ; ivm12     408.12 ien
 ; ivm13     408.13 ien
 ; ivmmtien  408.31 ien
 ;
 ; note: 408.13 fields were added to 408.41 before 408.12 field
 ;
 K DR S IVM41=0
 F  S IVM41=$O(^DGMT(408.41,"D",IVMMTIEN,IVM41)) Q:'IVM41  D
 .S IVM411=$G(^DGMT(408.41,+IVM41,0))
 .Q:$P(IVM411,"^",10)'=IVM13
 .S IVMOLD=$P(IVM411,"^",5)
 .S IVMOLD=$S(IVMOLD="":"@",1:IVMOLD)
 .S IVMFILE=$P(IVMAR1($P(IVM411,"^",2)),";")
 .S IVMNOD=$P(IVMAR1($P(IVM411,"^",2)),";",2)
 .I IVMFILE=408.13 S DA=IVM13,DIE="^DGPR(408.13,"
 .I IVMFILE=408.12 S DA=IVM12,DIE="^DGPR(408.12,"
 .S DR=IVMNOD_"////^S X=IVMOLD" D ^DIE K DA,DR,DIE
 .Q
 Q
 ;
EN1 ; change primary income test for year? code from 0 to 1 for VAMC MT
 S DA=IVMVAMC,DIE="^DGMT(408.31,",DR="2////1" D ^DIE K DA,DIE,DR
 ;
 ; delete 408.31
 ;
 S DA=IVMMTIEN,DIK="^DGMT(408.31," D ^DIK
 ;
 ; open IVM case record which was closed during upload
 S DA=$O(^IVM(301.5,"APT",+DFN,+DGLY,0))
 I $G(^IVM(301.5,+DA,0))']"" G MTBULL
 S DR=".04////0",DIE="^IVM(301.5," D ^DIE
 K ^IVM(301.5,DA,1)
 ;
MTBULL ; build and transmit mail message to IVM mail group notifying site
 ; that a means test was deleted.
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="IVM - MEANS TEST DELETED"
 S IVMTEXT(1)="An Income Verification Match Means Test was deleted for the"
 S IVMTEXT(2)="following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="    NAME:          "_$P(IVMPAT,"^")
 S IVMTEXT(5)="    ID:            "_$P(IVMPAT,"^",2)
 S Y=IVMMTDT X ^DD("DD")
 S IVMTEXT(6)="    DATE OF TEST:  "_Y
 S IVMTEXT(7)=" "
 S IVMTEXT(8)="NOTE:  The original DHCP Means Test is now the primary Means Test."
 D MAIL^IVMUFNC()
 ;
 ; call event driver
 S DGMTINF=1,DGMTP=IVMNO,DGMTA=IVMVNO
 S DGMTACT="DUP",DGMTI=IVMVAMC D EN^DGMTEVT
 S DGMTACT="DEL",DGMTI=IVMMTIEN D EN^DGMTEVT
 ;
 ; cleanup
 K DA,DFN,DGINC,DGINR,DGLY,DGMTA,DGMTACT,DGMTI,DGMTINF,DGMTP
 K DIE,DIK,DR,IVM12,IVM121,IVM13,IVM41,IVM411,IVMFILE
 K IVMFLGC,IVMMTDT,IVMMTIEN,IVMN,IVMNO,IVMNOD,IVMOLD
 K IVMPAT,IVMSOT,IVMTEXT,IVMVAMC,IVMVAMCA,IVMVNO,XMSUB,Y
 Q
 ;
SETUPAR ; create array ivmar1
 ; subscript is 408.42 node (type of change - name, dob, ssn, sex, relationship)
 ; 1st piece is file 408.12 or 408.13
 ; 2nd piece is 408.12 or 408.13 field #
 F IVM41=4:1 S IVM411=$P($T(TYPECH+IVM41),";;",2) Q:IVM411="QUIT"  D
 .S IVMAR1($P(IVM411,";"))=$P(IVM411,";",2,3)
 K IVM41,IVM411
 Q
 ;
TYPECH ; type of dependent changes 408.41/408.42
 ; 1st piece - 408.42 table file node
 ; 2nd piece - file (408.12/408.13)
 ; 3rd piece - 408.12/408.13 field
 ;;16;408.13;.01
 ;;17;408.13;.03
 ;;18;408.13;.09
 ;;19;408.13;.02
 ;;20;408.12;.02
 ;;QUIT
