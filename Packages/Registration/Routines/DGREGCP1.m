DGREGCP1 ;ALB/CLT,ARF - ADDRESS COPY UTILITIES ; 18 May 2017  2:54 PM
 ;;5.3;Registration;**941,1010,1040,1056**;Aug 13, 1993;Build 18
 ;
RESDISP(DFN) ;DISPLAY THE RESIDENTIAL ADDRESS
 N DGA1,DGA2,DGA3,DGA4,DGA9,DGA10,DGA1315,DGZIP
 N DGE,DGXX,DGFORGN,X,Y,DGCIEN,DGST,DGCNTRY,DGCNTY
 ;DG*5.3*1056 remove Permanent from the message following displayed message
 W !,"Residential Address to copy to the Mailing Address:",!
 I $G(^DPT(DFN,.115))="" D  Q
 .W !?5,"NO RESIDENTIAL ADDRESS"
 ;DISPLAY THE CURRENT RESIDENTIAL ADDRESS
 S DGXX=^DPT(DFN,.115),DGA1=$P(DGXX,"^",1),DGA2=$P(DGXX,"^",2),DGA3=$P(DGXX,"^",3),DGA4=$P(DGXX,"^",4)
 S DGA9=$P(DGXX,"^",9)
 S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA10),1,25),DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1 W:$G(DGA2)'="" !?3,DGA2 W:$G(DGA3)'="" !?3,DGA3
 ;FORDISP ;DISPLAY FOREIGN ADDRESS
 I DGA1="" W !
 I 'DGFORGN D
 . W ?43,"County: "
 . I $P(DGXX,U,5)=""!($P(DGXX,U,7)="") W "UNKNOWN" Q
 . I $P(DGXX,U,7)'="" I $D(^DIC(5,$P(DGXX,U,5),1,$P(DGXX,U,7),0)) D
 .. S DGST=$P(DGXX,U,5),DGCIEN=$P(DGXX,U,7)
 .. S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN) W $P(DGCNTY,"^",1),"(",$P(DGCNTY,"^",3),")"
 E  D
 . W ?43,"Province: "
 . W $S($P(DGXX,U,8)'="":$P(DGXX,U,8),1:"UNKNOWN")
 ;I DGFORGN W !?3,DGA9_" "_DGA4 ;DG*1010 comment out
 I DGFORGN W !?3,DGA4_" "_DGA9 ;DG*1010 - display postal code last
 I 'DGFORGN W !?3,DGA4 D
 . I $D(^DIC(5,+$P(^DPT(DFN,.115),"^",5),0)) W ",",$P(^DIC(5,+$P(^DPT(DFN,.115),"^",5),0),"^",2)
 . S DGZIP=$P(^DPT(DFN,.115),"^",6) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W "  ",DGZIP
 W !?3,DGCNTRY,!
 Q
 ;
PERMDISP(DFN) ;DISPLAY MAILING ADDRESS
 N DGA1,DGA9,DGA10,DGA1315,DGA2,DGA3,DGA4,DGZIP
 N DGE,DGXX,DGFORGN,X,Y,DGCIEN,DGST,DGCNTRY,DGCNTY
 ;DG*5.3*1056 remove Permanent from the message following display messages and comment
 W !,"Mailing Address to copy to Residential Address:",!
 I $G(^DPT(DFN,.11))="" D  Q
 .W !?5,"NO MAILING ADDRESS"
 ;DISPLAY THE CURRENT MAILING ADDRESS
 S DGXX=^DPT(DFN,.11),DGA1=$P(DGXX,"^",1),DGA2=$P(DGXX,"^",2),DGA3=$P(DGXX,"^",3),DGA4=$P(DGXX,"^",4)
 S DGA9=$P(DGXX,"^",9)
 S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA10),1,25),DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1 W:$G(DGA2)'="" !?3,DGA2 W:$G(DGA3)'="" !?3,DGA3
 ;FORGNCHK ;CHECK FOR FOREIGN ADDRESS
 I DGA1="" W !
 I 'DGFORGN D
 . W ?43,"County: "
 . I $P(DGXX,U,5)=""!($P(DGXX,U,7)="") W "UNKNOWN" Q
 . I $P(DGXX,U,7)'="" I $D(^DIC(5,$P(DGXX,U,5),1,$P(DGXX,U,7),0)) D
 .. S DGST=$P(DGXX,U,5),DGCIEN=$P(DGXX,U,7)
 .. S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN) W $P(DGCNTY,"^",1),"(",$P(DGCNTY,"^",3),")"
 E  D
 . W ?43,"Province: "
 . W $S($P(DGXX,U,8)'="":$P(DGXX,U,8),1:"UNKNOWN")
 ;I DGFORGN W !?3,DGA9_" "_DGA4 ;DG*1010 comment out
 I DGFORGN W !?3,DGA4_" "_DGA9 ;DG*1010 - display postal code last
 I 'DGFORGN W !?3,DGA4 D
 . I $D(^DIC(5,+$P(^DPT(DFN,.11),"^",5),0)) W ",",$P(^DIC(5,+$P(^DPT(DFN,.11),"^",5),0),"^",2)
 . S DGZIP=$P(^DPT(DFN,.11),"^",6) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W "  ",DGZIP
 W !?3,DGCNTRY,!
 Q
 ;
RESMVQ(DFN) ;DISPLAY RESIDENTIAL ADDRESS AND QUESTION IF COPY TO PERM IS DESIRED
 I $G(^DPT(DFN,.115))="" Q
 N DIR,X,Y,DTOUT,DUOUT
 ;DG*5.3*1056 remove Permanent from the message following displayed prompts
 S DIR(0)="Y",DIR("A")="Copy the Residential Address to the Mailing Address",DIR("B")="NO"
 S DIR("?",1)="Enter 'YES' to copy the Residential Address ",DIR("?")="to the Mailing Address."
 D ^DIR
 ; DG*5.3*1040 - Check for timeout of the Copy prompt
 I $D(DTOUT) S DGTMOT=1 Q
 I $G(Y)=1 D
 . W !
 . D RESDISP(DFN)
 . S DIR(0)="Y",DIR("A")="Are you sure you want to copy",DIR("B")=""
 . S DIR("?",1)="If you answer 'YES' the current Residential Address will be copied",DIR("?")="to the Permanent Mailing Address."
 . D ^DIR
 . ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 . I $D(DTOUT) S DGTMOT=1 Q
 . ; DG*5.3*1040 - QUIT if variable Y = 0
 . Q:$G(Y)=0
 . I $D(DUOUT)!$D(DIROUT) Q
 . D R2P^DGREGCOP(DFN)
 . W !,"Copy completed."
 . D EOP
 Q
 ;
PERMMVQ(DFN) ;DISPLAY MAILING ADDRESS AND QUESTION IF COPY TO RESIDENTIAL IS DESIRED
 ; First check for a valid Mailing Address that can be copied to residential address
 N DGXX,DGA10,DFORGN
 S DGXX=$G(^DPT(DFN,.11))
 ; Quit if nothing in Perm address line 1 field
 I $P(DGXX,"^",1)="" Q
 ; Quit if nothing in Perm address City field
 I $P(DGXX,"^",4)="" Q
 ; Quit if no Perm address zipcode defined for a domestic address
 S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 S DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I 'DGFORGN&($P(DGXX,"^",6)="") Q
 ; required address fields exist for copying to Residential address
 ; now check for PO Box or General Delivery address and notify user if not valid address and quit
 N DGADD,DIR,X,Y,DGRESADD,DGRESX
 K DIRUT
 I $$POBOXPM^DGREGCP2(DFN) D  Q
 . W !!?3,*7,"P.O. Box and GENERAL DELIVERY cannot be used in residential address." W !
 . ;DG*5.3*1056 remove Permanent from the following message displayed messages
 . W !,"Because the Mailing Address line 1 contains P.O. Box"
 . W " or General",!,"Delivery the Mailing Address cannot be copied to"
 . W !,"the Residential Address."
 . D EOP
 . ; DG*5.3*1040 - Check for timeout
 . Q:+$G(DGTMOT)
 ; Perm address is valid for use as a Residential address
ASK ; 
 W !
 ;DG*5.3*1056 remove Permanent from the following message displayed message and prompt
 S DIR(0)="Y",DIR("A")="Copy the Mailing Address to the Residential Address"
 S DIR("?",1)="Answer 'YES' or 'NO'. 'YES' will copy the current Mailing Address",DIR("?")="to the Residential Address."
 D ^DIR
 I X="Y"!(X="YES") S Y=1,Y(0)="YES"
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 I $D(DTOUT) S DGTMOT=1 Q
 ; DG*5.3*1040 - QUIT if Y = 0
 Q:$G(Y)=0
 I $D(DUOUT)!$D(DIROUT) Q
 I $D(DIRUT) G ASK
 I Y=1 D
 . W !
 . D PERMDISP(DFN) ;; W !! D RESDISP(DFN) W !
 . S DIR(0)="Y",DIR("A")="Are you sure you want to copy",DIR("B")=""
 . ;DG*5.3*1056 remove Permanent from the following message displayed prompt
 . S DIR("?",1)="If you answer 'YES' the current Mailing Address will be copied",DIR("?")="to the Residential Address."
 . D ^DIR
 . ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 . I $D(DTOUT) S DGTMOT=1 Q
 . ; DG*5.3*1040 - QUIT if Y = 0
 . Q:$G(Y)=0
 . I $D(DUOUT)!$D(DIROUT) Q
 . D P2R^DGREGCOP(DFN)
 . W !,"Copy completed."
 . D EOP
 ; DG*5.3*1040 - Check for timeout
 Q:+$G(DGTMOT)
 Q
EOP ;End of page prompt
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 ; DG*5.3*1040 - Set variable DGTMOT=1 to track timeout
 I $D(DTOUT) S DGTMOT=1 Q
 Q
