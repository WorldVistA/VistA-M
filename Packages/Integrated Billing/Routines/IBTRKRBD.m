IBTRKRBD ;WAS/RFJ - claims tracking - deleted admission bulletin ; 1 Mar 96
 ;;Version 2.0 ; INTEGRATED BILLING ;**56**; 21-MAR-94
 ;
DELBULL(DFN,IBTRN,DGPMA,IBSPEC) ; -- send deleted admission bulletin
 ;  dfn    = patient ien file 2
 ;  ibtrn  = claims tracking ien file 356
 ;  dgpma  = 0th node from movement file 405
 ;  ibspec = specialty ien file 45.7
 N %,DA,FILE,HDRFLAG,IBT,IBTDATE,LINE,SERVICE,SPECALTY,VA,VAERR,Y
 S IBT(1)="The following claims tracking patient's admission has been deleted from the"
 S IBT(2)="movement file (405).  The patient's entry in the claims tracking file (356)"
 S IBT(3)="has been set to inactive.  If the same patient is admitted to the hospital"
 S IBT(4)="with an admission date 5 days before or after the original admission date"
 S IBT(5)="the patient's entry in the claims tracking file (356) will be reactivated."
 S IBT(6)=""
 ;
 D PID^VADPT
 S IBT(7)="                Patient: "_$P(^DPT(DFN,0),"^")_" ("_VA("PID")_")"
 S IBT(8)="  Claims Tracking Entry: "_IBTRN
 S IBT(9)="  Claims Tracking    ID: "_$P($G(^IBT(356,+IBTRN,0)),"^")
 ;
 S Y=$P(DGPMA,"^") D DD^%DT
 S IBT(10)="Original Admission Date: "_Y_"   ("_$P(DGPMA,"^",14)_")"
 S IBT(11)=""
 ;
 S IBT(12)="  =============== ADMISSION DATA ==============="
 S SPECALTY=$P($G(^DIC(45.7,+IBSPEC,0)),"^",2)
 S IBT(13)="      Specialty: "_$P($G(^DIC(45.7,+IBSPEC,0)),"^")
 ;
 S SERVICE=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+IBSPEC,0)),"^",2),0)),"^",3)
 S IBT(14)="        Service: "_$$EXPAND^IBTRE(42.4,3,SERVICE)
 S IBT(15)="  Ward Location: "_$S($D(^DIC(42,+$P(DGPMA,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN")
 S IBT(16)="       Room-Bed: "_$S($D(^DG(405.4,+$P(DGPMA,"^",7),0)):$P(^(0),"^",1),1:"UNKNOWN")
 S IBT(17)="   Admitting DX: "_$P(DGPMA,"^",10)
 S IBT(18)="  Type of Admit: "_$S($D(^DG(405.1,+$P(DGPMA,"^",4),0)):$P(^(0),"^",1),1:"")
 S IBT(19)="        Insured: "_$S($$INSURED^IBCNS1(DFN):"YES",1:"NO")
 ;
 S LINE=19
 ;
 F FILE=356.1,356.2 S (DA,HDRFLAG)=0 F  S DA=$O(^IBT(FILE,"C",+IBTRN,DA)) Q:'DA  D BUILD
 ;
 F FILE=356.9,356.91,356.94 S (DA,HDRFLAG)=0 F  S DA=$O(^IBT(FILE,"C",+$P(DGPMA,"^",14),DA)) Q:'DA  D BUILD
 ;
 S FILE=356.93,(IBTDATE,HDRFLAG)=0 F  S IBTDATE=$O(^IBT(FILE,"AMVD",+$P(DGPMA,"^",14),IBTDATE)) Q:'IBTDATE  S DA=0 F  S DA=$O(^IBT(FILE,"AMVD",+$P(DGPMA,"^",14),IBTDATE,DA)) Q:'DA  D BUILD
 ;
 ;  send the bulletin
 D SEND^IBTRKRBA("UR Claims Tracking Admission Deleted")
 Q
 ;
 ;
BUILD ;  build data for file and entry
 N FIELD,HDRDATA,IBDATA
 D INQUIRE^IBTRKRU(FILE,DA)
 I '$D(IBDATA) Q
 ;
 ;  store file name in msg (once for each file)
 I 'HDRFLAG S HDRFLAG=1 D FILE^DID(FILE,"","NAME","HDRDATA"),SET(" "),SET("  =============== "_$G(HDRDATA("NAME"))_" DATA (FILE "_FILE_") ===============")
 ;
 D SET($J("ENTRY NUMBER",35)_": "_DA)
 ;
 ;  do not show adm. movement field (pts to deleted 405 entry)
 S FIELD="" F  S FIELD=$O(IBDATA(FILE,DA_",",FIELD)) Q:FIELD=""  I FIELD'="ADMISSION MOVEMENT",IBDATA(FILE,DA_",",FIELD)'="" D SET($J(FIELD,35)_": "_IBDATA(FILE,DA_",",FIELD))
 D SET(" ")
 Q
 ;
 ;
SET(MSG) ;  set message text
 S LINE=LINE+1,IBT(LINE)=MSG
 Q
