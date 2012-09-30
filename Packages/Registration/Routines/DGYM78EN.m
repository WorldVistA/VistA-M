DGYM78EN ;ALB/MLI - Environment check for DG*5.3*78 ; 3/4/96 @ 815
 ;;5.3;Registration;**78**;Aug 13, 1993
 ;
 ; This enviroment check routine will ensure that patches RT*2*22
 ; and DG*5.3*72 are installed prior to installation of this patch.
 ; It will abort if these patches haven't been installed.
 ;
EN ; begin processing
 I '$D(^DD(190,300)) D  ; check for old barcode field
 . W !!,*7,">>> You must install patch RT*2*22 first!"
 . S XPDQUIT=2
 I '$D(^DD(2,.6)) D  ; check for test pt indicator
 . W !!,*7,">>> You must install patch DG*5.3*72 first!"
 . S XPDQUIT=2
 I $G(XPDQUIT) W !!,">>> Installation aborted."
 I '$G(XPDQUIT) D
 . W !!,"Patches RT*2*22 and DG*5.3*72 found..."
 . I XPDENV=1 W "continuing with installation"
 Q
