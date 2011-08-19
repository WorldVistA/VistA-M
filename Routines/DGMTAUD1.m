DGMTAUD1 ;ALB/CAW,LD,BRM - Audit Changes to Means Tests - Con't ; 12/20/01 9:07am
 ;;5.3;Registration;**33,166,182,254,300,433**;Aug 13, 1993
 ;
D(I) ;Date function
 ;INPUT = Internal value of date
 ;OUTPUT= External value of date
 N DGX,Y
 S Y=I,DGX=$$FMTE^XLFDT(Y,"5F"),DGX=$TR(DGX," ","0")
 Q DGX
U(I) ;User function
 ;INPUT = Internal value (ptr) to NEW PERSON file
 ;OUTPUT= External value of .01 field (person name)
 N DGX
 S DGX=$P($G(^VA(200,+I,0)),U)
 Q DGX
C(I) ;Change type function
 ;INPUT = Internal value (ptr) to MEANS TEST CHANGES TYPE file
 ;OUTPUT= External value of .01 field (change type name)
 N DGX
 S DGX=$P($G(^DG(408.42,+I,0)),U)
 Q DGX
SR(I,DGMTI) ;Get source of test
 ;Input:
 ; I  = zeroth node of test from file #408.31
 ; DGMTI = Annual Means Test file (#408.31) IEN (OPTIONAL)
 ;
 ; Output:
 ;  DGX = external value of .01 field (name of source) OR
 ;        Station name
 ;
 N DGX
 S DGX=$P($G(^DG(408.34,+$P(I,"^",23),0)),U)
 ; check if the source is 'OTHER FACILITY'. If it is derive source
 ; from 'SITE CONDUCTING TEST' field (#2.05) in the Annual Means Test
 ; file (#408.31).
 I DGX="OTHER FACILITY",$D(DGMTI) D
 . N STA
 . ; exclude suffix to get Station # from 'SITE CONDUCTING TEST' field
 . S DGX(1)=$E($$GET1^DIQ(408.31,DGMTI,2.05),1,3)
 . ; get Institution NAME using STATION NUMBER field (#99) in Institution
 . ; file (#4)
 . D FIND^DIC(4,,99,,.DGX,1,"D",,,"STA")
 . S DGX=$G(STA("DILIST",1,1),DGX)
 Q DGX
S(I) ;MT status
 ;INPUT - Internal val of status from 408.31 (ptr to 408.32)
 ;OUTPUT - External val (.01 field)
 N DGX
 S DGX=$P($G(^DG(408.32,+I,0)),U)
 Q DGX
A(I) ;Agree to pay deduct
 ;INPUT - Internal val of agree to pay deduc. fld from file 408.31
 ;OUTPUT - External val of set
 N DGX
 S DGX=$P($G(^DD(408.31,.11,0)),U,3),DGX=$P($P(DGX,I_":",2),";",1)
 Q DGX
 ;
HDR ;Header
 W @IOF,!,"PATIENT: ",$E(DGNAM,1,38),?40,$P("MEANS^COPAY^^LTC EXEMPTION","^",DGMTYPT)_" TEST DATE: ",$$D^DGMTAUD1(DGMTD),!
 W ?40,$$SR^DGMTAUD1($G(^DGMT(408.31,DGMTI,0)))_" "_$P("MEANS^COPAY^^LTC EXEMPTION","^",DGMTYPT)_" TEST",!
 W ?33,"CHANGES",!!
 W ?2,"Date",?23,"Type of Change",?57,"User",!,DGDASH,!
 Q
