RADOSTIK ;HISC/GJC-Routine to print dosage tickets ;8/1/97  14:07
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #2056 reference to GET1^DIQ
 ;Supported IA #10103 reference to NOW^XLFDT and FMTE^XLFDT
 ;Supported IA #10104 reference to CJ^XLFSTR and REPEAT^XLFSTR
 ;Supported IA #2053 reference to FILE^DIE
 ;
EN1(RADFN,RADTI,RACNI) ; the usual suspects
 N I,RA1,RADTIK,RARDIO,RAY2,RAY3
 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)),RA1=0
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),RARDIO=+$P(RAY3,"^",28)
 S RADTIK=+$P($G(^RA(79.1,+$P(RAY2,"^",4),0)),"^",23)
 Q:'RADTIK  ; no dosage ticket printer defined for this imaging location
 Q:'RARDIO  ; no Rpharms associated with this exam
 Q:+$P(RAY3,"^",29)  ; quit if dosage ticket has already been printed
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTDESC="Rad/Nuc Med Print dosage ticket or tickets for an Exam"
 S ZTDTH=$H,ZTIO=$$GET1^DIQ(3.5,RADTIK_",",.01),ZTRTN="PRINT^RADOSTIK"
 F I="RADFN","RARDIO","RAY2","RAY3" S ZTSAVE(I)=""
 D ^%ZTLOAD D SETFLG^RADOSTIK(RADFN,RADTI,RACNI)
 Q
EN2 ; Print duplicate dosage ticket
 D:'$D(RACCESS(DUZ)) SET^RAPSET1 D ^RACNLU Q:X["^"
 N I,RADOSTIK,RARDIO,RAY2,RAY3
 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)),RADOSTIK=""
 S RAY3=Y(0),RARDIO=+$P(RAY3,"^",28) ; RAY3 is the zero node of the exam
 ; RADFN,RADTI & RACNI are all defined!
 I 'RARDIO D  D KILL Q
 . W !!?3,"Dosage ticket data does not exist!",$C(7)
 . Q
 N ZTDESC,ZTRTN,ZTSAVE S ZTRTN="PRINT^RADOSTIK"
 F I="RADFN","RADOSTIK","RARDIO","RAY2","RAY3" S ZTSAVE(I)=""
 S ZTDESC="Rad/Nuc Med Print Duplicate Dosage Ticket option."
 D ZIS^RAUTL I RAPOP D KILL Q
 D PRINT,KILL
 Q
PRINT ; Print out dosage ticket(s).  If more than one rpharm, print one
 ; dosage ticket per page.
 U IO S:$D(ZTQUEUED) ZTREQ="@"
 W:$D(RADOSTIK)&($E(IOST,1,2)="C-") @IOF
 N RA1,RA702,RA719,RACNST,RANOTE,RAPRTDT,RATTLE,RAX,RAXIT
 S (RA1,RAXIT)=0
 S RATTLE="Radiopharmaceutical Dose Computation and Measurement Record"
 S RAPRTDT=$$NOW^XLFDT()
 S:$L($P(RAPRTDT,".",2))>4 RAPRTDT=$P(RAPRTDT,".")_"."_$E($P(RAPRTDT,".",2),1,4) ; don't display seconds in printed date
 S RAPRTDT="Printed: "_$$FMTE^XLFDT(RAPRTDT,"1P"),RACNST=$L(RAPRTDT)
 F  S RA1=$O(^RADPTN(RARDIO,"NUC",RA1)) Q:RA1'>0  D  Q:RAXIT
 . K RANOTE W !,$$CJ^XLFSTR(RATTLE,IOM),!,$$CJ^XLFSTR(RAPRTDT,IOM)
 . I $D(ZTQUEUED),($D(RADOSTIK)) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 . Q:RAXIT
 . W !!,"Case                    : ",$P(RAY3,"^")_"@"_$$FMTE^XLFDT($P(RAY2,"^"),"1P")
 . W !!,"Patient                 : ",$$GET1^DIQ(2,RADFN_",",.01)
 . W !,"Patient ID              : ",$$SSN^RAUTL()
 . W !,"Study                   : ",$E($$GET1^DIQ(71,+$P(RAY3,"^",2)_",",.01),1,50)
 . S RA702=$G(^RADPTN(RARDIO,"NUC",RA1,0))
 . W !!,"Radiopharmaceutical     : "
 . S RAX=$$EN1^RAPSAPI(+$P(RA702,"^"),.01) S:RAX="" RANOTE=""
 . W $S(RAX]"":RAX,1:"*****") K RAX
 . W !,"Form                    : ",$$GET1^DIQ(70.21,RA1_","_RARDIO_",",15)
 . D GETS^DIQ(71.9,+$P(RA702,"^",13)_",","*","","RA719")
 . W !,"Lot No.                 : " S RAX=$G(RA719(71.9,+$P(RA702,"^",13)_",",.01))
 . S:RAX="" RANOTE="" W $S(RAX]"":RAX,1:"*****") K RAX
 . W !,"Kit No.                 : ",$G(RA719(71.9,+$P(RA702,"^",13)_",",4))
 . W !,"Lot Expiration Date     : " S RAX=$G(RA719(71.9,+$P(RA702,"^",13)_",",3))
 . S:RAX="" RANOTE="" W $S(RAX]"":RAX,1:"*****") K RAX
 . W !!,"Date/Time of Measurement: " S RAX=$$GET1^DIQ(70.21,RA1_","_RARDIO_",",5)
 . S:RAX="" RANOTE="" W $S(RAX]"":RAX,1:"*****") K RAX
 . W !,"Dose Prescribed         : "
 . I $P(RA702,"^",2)]"" W $P(RA702,"^",2)_" mCi"
 . I $P(RA702,"^",2)']"",(+$O(^RAMIS(71,+$P(RAY3,"^",2),"NUC","B",$P(RA702,"^"),0))) D
 .. N RA7108 S RA7108=+$O(^RAMIS(71,+$P(RAY3,"^",2),"NUC","B",$P(RA702,"^"),0))
 .. S RA7108(0)=$G(^RAMIS(71,+$P(RAY3,"^",2),"NUC",RA7108,0))
 .. W:$P(RA7108(0),"^",6)]"" "Low: "_$P(RA7108(0),"^",6)_" mCi   "
 .. W:$P(RA7108(0),"^",5)]"" "High: "_$P(RA7108(0),"^",5)_" mCi"
 .. Q
 . W !,"Activity Drawn          : ",$S($P(RA702,"^",4)]"":$P(RA702,"^",4)_" mCi",1:"*****")
 . S:$P(RA702,"^",4)="" RANOTE=""
 . W !,"Dose Administered       : ",$S($P(RA702,"^",7)]"":$P(RA702,"^",7)_" mCi",1:"")
 . W !,"Time of Administration  : ",$$GET1^DIQ(70.21,RA1_","_RARDIO_",",8)
 . W !!,"Signature of Person Measuring Dose: "
 . W $$REPEAT^XLFSTR("_",((IOM-3)-$X)) K RA719
 . W:$D(RANOTE) !!,"NOTE: '*****' indicates that required pieces of information are missing."
 . S:'$D(ZTQUEUED)&($D(RADOSTIK))&(+$O(^RADPTN(RARDIO,"NUC",RA1))) RAXIT=$$EOS^RAUTL5()  Q:RAXIT
 . W:+$O(^RADPTN(RARDIO,"NUC",RA1)) @IOF ; dosage ticket per page
 . Q
 D CLOSE^RAUTL,KILL^RADOSTIK
 Q
KILL ; Kill variables
 K %,%W,%Y,%Y1,C,RACN,RACNI,RADATE,RADFN,RADTE,RADTI,RANME,RAPOP,RAPRC
 K RARPT,RASSN,RAST,X,Y
 K DIC,DIPGM,DISYS,DUOUT,I,RAHEAD,RAI,RAMES,RAEND,RAFL,RAFST,RAHEAD,RAIX
 K ^TMP($J,"RAEX")
 Q
SETFLG(RADFN,RADTI,RACNI) ; Set the 'Dosage Ticket Printed?'
 ; ^DD(70.03,29,0) field to 'Yes'.
 ; Input: RADFN==> Patient ien     RADTI==> Inverse Date/Time of Exam
 ;        RACNI==> ien of the examination
 N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",29)=1
 D FILE^DIE("","RAFDA")
 Q
