LA7UID ;DALIO/JRR - BUILD HL7 DOWNLOAD TO UI ;May 20, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,57,66**;Sep 27, 1994;Build 30
 ;
 Q
 ;
EN ; This line tag is called from ^LADOWN when downloading
 ; a load work list to the Auto Instrument.  LADOWN1 should
 ; have already built ^TMP($J with all of the atomic and
 ; cosmic tests, ^TMP("LA7",$J holds all of the Instrument defined
 ; tests from 62.4.
 ; LRLL= IEN in 68.2 Load Worklist file, from field in 62.4
 ; LRINST= IEN IN 62.4 Auto Inst file
 ; LRAUTO= zero node of 62.4 entry
 ;
 N LA7MODE
 S LA7INST=LRINST
 I '$G(LA7ADL) D BLDINST^LA7ADL1(LA7INST,LRLL)
 S LA76248=$P($G(^LAB(62.4,+$G(LRINST),0)),"^",8)
 I 'LA76248 D  Q
 . S XQAMSG="MESSAGE CONFIGURATION not defined in AUTO INSTRUMENT file for "_$P(LRAUTO,"^")
 . D ERROR,EXIT
 . I '$D(ZTQUEUED) D  ;
 . . W $C(7),!!,"You must have a MESSAGE CONFIGURATION defined in field 8 of"
 . . W !,"the AUTO INSTRUMENT file before downloading to this instrument!"
 . ;
 ;
 I '$P(^LAHM(62.48,LA76248,0),"^",3) D  Q
 . S XQAMSG="STATUS field in the LA7 MESSAGE PARAMETER file not turned on for "_$P(LRAUTO,"^")
 . D ERROR,EXIT
 . I '$D(ZTQUEUED) D  ;
 . . W $C(7),!!,"The STATUS field in the LA7 MESSAGE PARAMETER file must be "
 . . W !,"turned on before downloading to this instrument!"
 . ;
 ;
 S LA7MODE=$P(^LAHM(62.48,LA76248,0),"^",4)
 ;
 ; Call the routine specified in the PROCESS DOWNLOAD field in file 62.48
 ; Download for one whole load list is done
 X $G(^LAHM(62.48,LA76248,2))
 ;
EXIT I '$G(LA7ADL) K ^TMP("LA7",$J),LA76248
 Q
 ;
 ;
ERROR ; Send warning of error in Auto Instrument file configuration.
 S XQA("G.LAB MESSAGING")=""
 D SETUP^XQALERT
 K XQA,XQAMSG
 Q
