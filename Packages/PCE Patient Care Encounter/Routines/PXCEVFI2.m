PXCEVFI2 ;ISL/dee,ESW - Supporting routines for editing a visit or v-file entry ; 4/24/07 4:27pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,73,95,96,124,158,184**;Aug 12, 1996;Build 30
 ;
 Q
ASK(PXCVIEN,PXCFIEN,PXCEAUPN,PXCCATT,PXCCODE) ; -- Display a selection list from one V-File for this visit
 N PXCEINDX,PXCECNT,PXCEASK,PXCEREF
 N DIR,DA,X,Y
 S PXCEINDX=""
 F PXCECNT=0:1 S PXCEINDX=$O(@(PXCEAUPN_"(""AD"",PXCVIEN,PXCEINDX)")) Q:'PXCEINDX  D
 . I PXCECNT=0&(PXCCATT="Diagnosis") D SC($P(^AUPNVSIT(PXCEVIEN,0),U,5))
 . I PXCECNT=0&(PXCCATT="CPT") D SC($P(^AUPNVSIT(PXCEVIEN,0),U,5))
 . W:PXCECNT=0 !!,"--- "_PXCCATT_" ---",!
 . S PXCEASK(PXCECNT+1)=PXCEINDX
 . W !,$J(PXCECNT+1,3),?6,@("$$DISPLY01^"_PXCCODE_"("_PXCEAUPN_"(PXCEINDX,0))")
 Q:PXCECNT'>0
ASKLOOP S DIR(0)="FAO^1:"_$L(PXCECNT)
 S DIR("A")="Enter 1-"_PXCECNT_" to Edit, or 'A' to Add: "
 S DIR("?")="Enter the number of the "_PXCCATT_" you wish to edit or A to add a new "_PXCCATT_"."
 D ^DIR
 K DIR,DA
 I $D(DIRUT) S PXCEQUIT=1 Q
 Q:"Aa"[Y
 G:Y<1!(Y>PXCECNT) ASKLOOP
 G:$G(PXCEASK(Y))'>0 ASKLOOP
 S PXCFIEN=$G(PXCEASK(Y))
 Q
 ;
SAVE ; -- Save this edited and quit editing.
 I PXCECAT="CSTP" S PXCEFIEN=$$STOPCODE^PXUTLSTP(PXCESOR,$P(PXCEAFTR(0),"^",8),PXCEVIEN)
 E  D
 . N PXCENODS,PXCEFOR,PXCENODE,PXCESEQ
 . S PXCENODS=$P($T(FORMAT^@PXCECODE),"~",3)
 . F PXCEFOR=1:1 S PXCENODE=$P(PXCENODS,",",PXCEFOR) Q:PXCENODE']""  D
 .. I PXCENODE=1,PXCECATS="CPT" D  Q
 ... S PXCESEQ=""
 ... F  S PXCESEQ=$O(PXCEAFTR(PXCENODE,PXCESEQ)) Q:PXCESEQ=""  D
 .... S ^TMP("PXK",$J,PXCECATS,1,PXCENODE,PXCESEQ,"AFTER")=PXCEAFTR(PXCENODE,PXCESEQ)
 .. S ^TMP("PXK",$J,PXCECATS,1,PXCENODE,"AFTER")=PXCEAFTR(PXCENODE)
 . I PXCECAT="SK",$G(^TMP("PXK",$J,PXCECATS,1,"IEN"))]"" D SAVE^PXCESK
 . D EN1^PXKMAIN
 . I PXCECAT="SIT"!(PXCECAT="APPM")!(PXCECAT="HIST") S PXCEVIEN=^TMP("PXK",$J,"VST",1,"IEN")
 Q
 ;
DEL(PXCECAT) ; -- Delete this V-File entry from the List if all the visit information.
 I PXCEFIEN'>0!(PXCEVIEN'>0) W !!,$C(7),"Error: Cannot delete this an unknown V-File entry." D PAUSE^PXCEHELP Q
 I PXCEKEYS'["D",PXCEKEYS'["d" W !!,$C(7),"Error: You do not have delete access." D PAUSE^PXCEHELP Q
 ;
 N PXCENODS,PXCEFOR,PXCENODE,PXCECATS,PXCECATT,PXCECODE,PXCEAUPN,PXCEQUIT
 S PXCECODE="PXCE"_$S(PXCECAT="IMM":"VIMM",1:PXCECAT)
 S PXCECATS=$S(PXCECAT="CSTP":"VST",PXCECAT="HIST":"VST",1:PXCECAT)
 S PXCEAUPN=$P($T(FORMAT^@PXCECODE),"~",5)
 S PXCECATT=$P($P($T(FORMAT^@PXCECODE),";;",2),"~",1)
 ;
 I '$D(@(PXCEAUPN_"(PXCEFIEN)")) Q
 I $P($G(@(PXCEAUPN_"(PXCEFIEN,812)")),"^",1) D  Q
 . W !!,"Error on deleting "_PXCECATT_" ",@("$$DISPLY01^"_PXCECODE_"(@(PXCEAUPN_""(PXCEFIEN,0)""))")
 . W !,"Error: You cannot delete this entry it has been ""Verified""." D WAIT^PXCEHELP
 I PXCEKEYS'["D" D  Q:PXCEQUIT
 . N PXCECHK
 . S PXCEQUIT=0
 . I PXCECATS="VST" S PXCECHK=$P($G(@(PXCEAUPN_"(PXCEFIEN,0)")),"^",23)
 . E  S PXCECHK=$P($P($P($G(@(PXCEAUPN_"(PXCEFIEN,801)")),"^",2),";",1)," ",2)
 . I DUZ'=PXCECHK D
 .. S PXCEQUIT=1
 .. N NODE0
 .. S NODE0=@(PXCEAUPN_"(PXCEFIEN,0)")
 .. W !!,"Error on deleting "_PXCECATT_" ",@("$$DISPLY01^"_PXCECODE_"(NODE0)")
 .. W !,"Error: You cannot delete an entry you did not create." D WAIT^PXCEHELP
 ;
 I PXCECAT="CSTP" D
 . W !!,"Deleting "_PXCECATT_" "
 . W @("$$DISPLY01^"_PXCECODE_"($G(@(PXCEAUPN_""(PXCEFIEN,0)"")))")
 . Q:'$$SURE^PXCEAE2
 . N PXCERESU
 . S PXCERESU=$$STOPCODE^PXUTLSTP(PXCESOR,"@",PXCEVIEN,PXCEFIEN)
 . S:$D(PXCELOOP) PXCELOOP=1
 E  I PXCECATS="VST" D
 . W !!,"Deleting "_PXCECATT_" "
 . W @("$$DISPLY01^"_PXCECODE_"($G(@(PXCEAUPN_""(PXCEFIEN,0)"")))")
 . Q:'$$SURE^PXCEAE2
 . N PXCERESU
 . S PXCERESU=$$KILL^VSITKIL(PXCEVIEN)
 . I PXCERESU D
 .. I PXCERESU=1,$O(^SCE("AVSIT",PXCEVIEN,"")) Q
 .. W !,$C(7),"Could not delete the encounter.  There are still users of it." D WAIT^PXCEHELP
 . I 'PXCERESU S PXCEVDEL=1 S:$D(PXCELOOP) (PXCELOOP,PXCEQUIT,PXCENOER)=1
 . D EVENT^PXKMAIN
 ;
 E  D
 . K ^TMP("PXK",$J)
 . S ^TMP("PXK",$J,"VST",1,"IEN")=PXCEVIEN
 . F PXCENODE=0,21,150,800,811,812 D
 .. S (^TMP("PXK",$J,"VST",1,PXCENODE,"AFTER"),^TMP("PXK",$J,"VST",1,PXCENODE,"BEFORE"))=$G(^AUPNVSIT(PXCEVIEN,PXCENODE))
 . ;
 . S ^TMP("PXK",$J,"SOR")=PXCESOR
 . S ^TMP("PXK",$J,PXCECATS,1,"IEN")=PXCEFIEN
 . ;
 . S PXCENODS=$P($T(FORMAT^@PXCECODE),"~",3)
 . F PXCEFOR=1:1 S PXCENODE=$P(PXCENODS,",",PXCEFOR) Q:PXCENODE']""  D
 .. S ^TMP("PXK",$J,PXCECATS,1,PXCENODE,"BEFORE")=$G(@(PXCEAUPN_"(PXCEFIEN,PXCENODE)"))
 . ;
 . N DIK,DA
 . W !!,"Deleting "_PXCECATT_" "
 . W @("$$DISPLY01^"_PXCECODE_"(^TMP(""PXK"",$J,PXCECATS,1,0,""BEFORE""))")
 . Q:'$$SURE^PXCEAE2  ;DELQUIT
 . S PXCENODS=$P($T(FORMAT^@PXCECODE),"~",3)
 . F PXCEFOR=1:1 S PXCENODE=$P(PXCENODS,",",PXCEFOR) Q:PXCENODE']""  S ^TMP("PXK",$J,PXCECATS,1,PXCENODE,"AFTER")=$S(PXCENODE=0:"@",1:"")
 . D EN1^PXKMAIN
 . S:$D(PXCELOOP) PXCELOOP=1
 . I $D(PXCENOER)#2 S PXCENOER=1
 ;
DELQUIT ;
 K ^TMP("PXK",$J)
 Q
 ;
SC(PXDFN) ;Service Connected Help
 ; Input  -- DFN      Patient file IEN  
 ; Output -- Help
 N I,SDCNT,SDDC,SDRD0
 W !!,"Patient's Service Connection and Rated Disabilities:"
 W !!,$S($P($G(^DPT(PXDFN,.3)),"^")="Y":"        SC Percent: "_$P(^(.3),"^",2)_"%",1:" Service Connected: No")
 W !,"Rated Disabilities: "
 I $P($G(^DPT(PXDFN,"VET")),"^")'="Y",$S('$D(^DIC(391,+$G(^DPT(PXDFN,"TYPE")),0)):1,$P(^(0),"^",2):0,1:1) W "Not a Veteran" Q
 S (SDCNT,I)=0
 F  S I=$O(^DPT(PXDFN,.372,I)) Q:'I  I $P($G(^(I,0)),"^",3) S SDRD0=^(0) D
 .S SDCNT=SDCNT+1
 .S SDDC=$S('$D(^DIC(31,+SDRD0,0)):"",$P(^(0),"^",4)]"":$P(^(0),"^",4),1:$P(^(0),"^"))
 .W:SDCNT>1 !
 .W ?20,$P($G(^DIC(31,+SDRD0,0)),"^",3),?25,SDDC,"  (",$P(SDRD0,"^",2),"%-",$S($P(SDRD0,"^",3):"SC",1:""),")"
 I 'SDCNT W $S('$O(^DPT(PXDFN,.372,0)):"None Stated",1:"No Service Connected Disabilities Listed")
 ;
