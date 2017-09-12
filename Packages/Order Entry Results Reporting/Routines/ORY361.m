ORY361 ;ISL/TC - Post-install for patch OR*3*361 ;03/24/14  12:29
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**361**;Dec 17, 1997;Build 39
 ;
 ;  External References:
 ;  ^DIC    ICR #10006
 ;  ^DIE    ICR #10018
 ;
POST ; Initiate post-init processes
 N ORERR
 D BMES^XPDUTL("Setting default value of parameter ORQQPL SUPPRESS CODES to NO")
 D EN^XPAR("PKG","ORQQPL SUPPRESS CODES",1,"NO",.ORERR)
 I $D(ORERR) D BMES^XPDUTL("Error setting parameter: "_$P(ORERR,"^",2))
 D UPDTRPT
 Q
 ;
UPDTRPT ; Modify ICD Column Headers display text in PL Clinical Reports in OE/RR REPORTS file (101.24)
 N I
 F I=1:1:4  D
 .N DIC,DA,X,J,ORIFN
 .S DIC="^ORD(101.24,",DIC(0)="BIXZ"
 .S X=$S(I=1:"ORRPW PROBLEM ACTIVE",I=2:"ORRPW PROBLEM ALL",I=3:"ORRPW DOD PROBLEM LIST ALL",1:"ORRPW PROBLEM INACTIVE")
 .D ^DIC I Y=-1 K DIC Q  ; perform top file level search for record X, if unsuccessful quit
 .S DA(1)=+Y,DIC=DIC_DA(1)_",3,",DIC(0)="IXZ",ORIFN=DA(1)
 .I ORIFN>1000 D  ; if report is a national standard, then proceed to modify the below X fields in the subfile #101.243
 ..N ORDUPCOL,K,CNT,ORSUB
 ..D BMES^XPDUTL("Modifying the following column names of the "_X_" report:")
 ..F K=6:1:7  D  ; check for duplicate ICD column headers and delete them
 ...S CNT=0,ORSUB="" F  S ORSUB=$O(^ORD(101.24,ORIFN,3,"C",K,ORSUB)) Q:'ORSUB  D
 ....S CNT=CNT+1,ORDUPCOL(CNT)=ORSUB
 ...I CNT>1 D
 ....N L F L=2:1:CNT D
 .....N DIK,DA S DIK=DIC,DA(1)=ORIFN,DA=ORDUPCOL(L)
 .....D ^DIK K DIK
 ..F J=1:1:2  D
 ...N X
 ...S X=$S(J=1:"Primary ICD-9-CM Code & Description",J=2:"Secondary ICD-9-CM Code & Description")
 ...D ^DIC I Y=-1 K DIC Q  ;perform subfile entry level search for record X, if unsuccessful quit
 ...N DIE,DA,DR S DIE=DIC S DA=+Y,DA(1)=ORIFN
 ...S DR=".01///"_$S(J=1:"Primary ICD Code & Description",J=2:"Secondary ICD Code & Description")
 ...D BMES^XPDUTL("   From "_X_" to "_$P(DR,"///",2)_".")
 ...D ^DIE K DIE,DR,DA,Y Q  ;edit the COLUMN HEADERS text of the X COLUMN HEADER multiple accordingly
 ..K DIC Q
 .Q
 Q
 ;
