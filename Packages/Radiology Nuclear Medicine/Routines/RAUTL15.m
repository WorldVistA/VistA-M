RAUTL15 ;HISC/GJC-Skeleton rpt del if no data entered. ;11/5/99  12:33
 ;;5.0;Radiology/Nuclear Medicine;**5,10**;Mar 16, 1998
EN3(IEN74) ;Delete the skeleton report and pointer from Rad Pt file to
 ; report if user has not entered any report data (i.e. user ^'d out
 ; of report entry/edit after the system created a skeleton record).
 ; If the report is deleted, a bulletin will not be generated!
 N RA,RAPRG74,RATXT
 S RA(0)=$G(^RARPT(IEN74,0)) Q:RA(0)']"" 0
 I $O(^RARPT(IEN74,2005,0))>0 Q 0
 S RA("I")=$S(+$O(^RARPT(IEN74,"I",0))'>0:1,1:0)
 S RA("P")=$S($G(^RARPT(IEN74,"P"))="":1,1:0)
 S RA("R")=$S(+$O(^RARPT(IEN74,"R",0))'>0:1,1:0)
 S RA(5)=$P(RA(0),"^",5),RA(5)=$S(RA(5)]"":RA(5),1:"Null")
 I $L(RA(0),"^")'>6,("dD"[RA(5)),(RA("I")),(RA("P")),(RA("R")) D  Q 1
 . N %,D,D0,DA,DIC,DIE,DIK,DQ,DR,X,Y
 . ; +++++ Delete Report Text pointer from the Examinations     +++++
 . ; +++++     multiple in the Rad/Nuc Med Patient file         +++++
 . ; +++++        if the data is xrefed, delete xref            +++++
 . ; del other print member's REPORT TEXT xrefs, & set ptr to #74 as null
 . D DEL17^RARTE2(IEN74)
 . ; set RADFN, RADTI & RACNI if not defined!  This situation will arise
 . ; when this code finds an incomplete Rad/Nuc Med Report while running
 . ; the post-init portion of the software.
 . S:'$D(RADFN) RADFN=$P(RA(0),"^",2)
 . S:'$D(RADTI) RADTI=9999999.9999-$P(RA(0),"^",3)
 . S:'$D(RACNI) RACNI=+$O(^RADPT(RADFN,"DT",RADTI,"P","B",+$P(RA(0),"^",4),0))
 . S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 . D ENKILL^RAXREF(70.03,17,IEN74,.DA)
 . ; Delete pointers to the Rad/Nuc Med Report file i.e, '^RARPT('
 . ;*******
 . S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)="" K DA,X
 . ; +++++ Delete Report pntr from the Reports multiple in      +++++
 . ; +++++          the Reports Batches file                    +++++
 . ; +++++ Delete Report pntr from the Report Distribution file +++++
 . D UPDTPNT^RAUTL9(IEN74)
 . ; +++++ Delete the entry from the Rad/Nuc Med Reports file   +++++
 . S DA=IEN74,DIK="^RARPT(" D ^DIK
 . S RATXT(1)=" "
 . S RATXT(2)="   Report not complete.  Must Delete......deletion complete!"
 . S RATXT(3)=$C(7) D MES^XPDUTL(.RATXT)
 . Q
 Q 0
KMV ; kill miscellaneous variables
 K %DT,%I,%RET,%T
 K D,D0,D1,D2,D3,DA,DDER,DDH,DI,DIE,DIFLD,DIG,DIH,DISYS,DIU,DIW,DIWF,DIWL,DIWR,DIWT,DG,DK,DL,DM,DN,DR
 K POP
 Q
 ;
CZECH(Y) ; check if an order can be cancelled, held, or scheduled.
 ; Y  -> ien of the Rad/Nuc Med Orders file.
 ; Y1 -> if OE/RR > 2.5 & no order number: 1, else 0
 ; Called from: VALORD subroutine
 N RAORDER,Y1 S Y1=0
 S RAORDER(0)=$G(^RAO(75.1,+Y,0)) Q:RAORDER(0)']""
 I '$P(RAORDER(0),U,7),(+$$ORVR^RAORDU()>2.5) D
 . N Y2 ; 'Y2' is the procedure name
 . S Y1=1,Y2=$P($G(^RAMIS(71,+$P(RAORDER(0),U,2),0)),U)
 . D INV(RAOPTN,Y2)
 . Q
 Q Y1
INV(X,X1) ; invalid action message called from the schedule/cancel or hold
 ; request options.
 ; X  -> point of orgin (option)            X1 -> procedure name
 ; Called from: CZECH subroutine
 S X=$$UP^XLFSTR($E(X,1,3)),X1=$S(X1]"":X1,1:"Unknown")
 W !!?3,"Sorry, can't "_$S(X="SCH":"schedule",X="CAN":"cancel",1:"hold")
 W " this request until OE/RR assigns an order number"
 W !?3,"for procedure: ",X1,!?3,"Please try later!"
 Q
VALORD ; validate order data, i.e, has OE/RR order # and the site is running
 ; a version of OE/RR > 2.5  Called from: 2^RAORD, 3^RAORD & 4^RAORD
 N G1,G2,RA751 S G1=0
 F  S G1=$O(RAORDS(G1)) Q:G1'>0  D
 . S G2=$$CZECH(+$G(RAORDS(G1))) K:G2 RAORDS(G1)
 . Q
 Q
DPROC(RADFN,RADTI,RACNI,RAOIFN) ; Determine if the ordered procedure is
 ; different from the registered procedure.
 ; Input Variables: RADFN-Patient DFN
 ;                  RADTI-inverse DT of exam   (if exists)
 ;                  RACNI-IEN on the case node (if exists)
 ;                  RAOIFN-IEN of the order
 ; Output: null-procedures don't differ -OR- no order/exam
 ;         not null-ordered proc_"^"_registered proc data
 ;         registered procedure data includes imaging type, procedure
 ;         type and CPT codes (if any)
 ;
 ; NOTE: The only time we don't set ^TMP($J,"RA DIFF PRC") is when
 ; we are using the 'Detailed Request Display' option and the ordered
 ; procedure is the same as the registered procedure.  All other
 ; Request display options output the ordered procedure, the
 ; registered procedure and exam case number if the order
 ; is active.
 ;
 N RA7003,RA751
 S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RA751=$G(^RAO(75.1,RAOIFN,0))
 Q:$P(RA7003,"^",2)=""!($P(RA751,"^",2)="") "" ; missing order or xam
 I '$D(RAOPT("ORDERPRINTS")),'$D(RAOPT("ORDERPRINTPAT")) Q:$P(RA7003,"^",2)=$P(RA751,"^",2) "" ; except for 2 print options, quit if req.prc=regis.prc
 N RA71,RACPT,RACSE,RAITY,RAPRC,RATY,X,Y
 S RACSE=$$RJ^XLFSTR($P(RA7003,"^"),5)
 S RA71=$G(^RAMIS(71,$P(RA7003,"^",2),0))
 S RACPT=$P($$NAMCODE^RACPTMSC(+$P(RA71,"^",9),DT),"^")
 S RAPRC=$E($$GET1^DIQ(71,+$P(RA7003,"^",2)_",",.01),1,36)
 S RAITY=$$GET1^DIQ(79.2,+$P(RA71,"^",12)_",",3)
 S RATY=$$GET1^DIQ(71,$P(RA7003,"^",2)_",",6)
 S RATY=$E(RATY,1)_$$LOW^XLFSTR($E(RATY,2,9999))
 S X="",Y=RACSE_" "_RAPRC,Y(0)="("_RAITY_" "_RATY_" "_RACPT_")"
 S Y(0)=Y(0)_" "_$E($P($G(^RA(72,+$P(RA7003,"^",3),0)),"^"),1,4)
 S $E(X,1,42)=Y,$E(X,44,70)=Y(0)
 Q X
