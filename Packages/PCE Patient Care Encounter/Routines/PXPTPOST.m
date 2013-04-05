PXPTPOST ;ISL/MKB,DLT,dee - Patient/IHS install post-init ;8/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;;1.0;PCE Patient/IHS Subset;;Nov 01, 1994
EN ; entry point (not used)
 D LOC,MASTER,QUE
 Q
 ;
LOC ;Populate LOCATION file (#9999999.06)
 D LOC^PXPT
 Q
 ;
MASTER ;Populate the PXPT fields $501 & #502 in PCE PARAMETERS file (#815)
 D MASTER^PXPT
 ;
 D BMES^XPDUTL("Now remove the old PCC MASTER CONTROL file (#9001000)")
 N DIU
 S DIU=9001000
 S DIU(0)="DT"
 D EN^DIU2
 Q
 ;
QUE ; Queue job to populate IHS Patient File #9000001
 D QUE^PXPT
 Q
 ;
 ;
GETLOC D GETLOC^PXPT
 Q
 ;
