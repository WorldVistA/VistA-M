ORY212P ;SLC/MKB - Export Package Level Parameters ;2/11/08  11:07
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212**;Dec 17, 1997;Build 24
 ;
MAIN ; main (initial) parameter transport routine
 K ^TMP($J,"XPARRSTR")
 N ENT,IDX,ROOT,REF,VAL,I
 S ROOT=$NAME(^TMP($J,"XPARRSTR")),ROOT=$E(ROOT,1,$L(ROOT)-1)_","
 D LOAD
XX2 S IDX=0,ENT="PKG.ORDER ENTRY/RESULTS REPORTING"
 F  S IDX=$O(^TMP($J,"XPARRSTR",IDX)) Q:'IDX  D
 . N PAR,INST,ORVAL,ORERR
 . S PAR=$P(^TMP($J,"XPARRSTR",IDX,"KEY"),U),INST=$P(^("KEY"),U,2)
 . M ORVAL=^TMP($J,"XPARRSTR",IDX,"VAL")
 . D EN^XPAR(ENT,PAR,INST,.ORVAL,.ORERR)
 K ^TMP($J,"XPARRSTR")
 Q
 ;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 Q
 ;
DATA ; parameter data
 ;;9338,"KEY")
 ;;OR VBECS COMPONENT ORDER^5
 ;;9338,"VAL")
 ;;RED BLOOD CELLS
 ;;9339,"KEY")
 ;;OR VBECS COMPONENT ORDER^10
 ;;9339,"VAL")
 ;;FRESH FROZEN PLASMA
 ;;9340,"KEY")
 ;;OR VBECS COMPONENT ORDER^15
 ;;9340,"VAL")
 ;;PLATELETS
 ;;9341,"KEY")
 ;;OR VBECS COMPONENT ORDER^20
 ;;9341,"VAL")
 ;;CRYOPRECIPITATE
 ;;9342,"KEY")
 ;;OR VBECS COMPONENT ORDER^25
 ;;9342,"VAL")
 ;;WHOLE BLOOD
 ;;9343,"KEY")
 ;;OR VBECS COMPONENT ORDER^30
 ;;9343,"VAL")
 ;;OTHER
 ;;9344,"KEY")
 ;;OR VBECS MODIFIERS^5
 ;;9344,"VAL")
 ;;Washed
 ;;9345,"KEY")
 ;;OR VBECS MODIFIERS^10
 ;;9345,"VAL")
 ;;Irradiated
 ;;9346,"KEY")
 ;;OR VBECS MODIFIERS^15
 ;;9346,"VAL")
 ;;Leuko Reduced
 ;;9347,"KEY")
 ;;OR VBECS MODIFIERS^20
 ;;9347,"VAL")
 ;;Volume Reduced
 ;;9348,"KEY")
 ;;OR VBECS MODIFIERS^25
 ;;9348,"VAL")
 ;;Divided
 ;;12731,"KEY")
 ;;OR VBECS MODIFIERS^30
 ;;12731,"VAL")
 ;;Leuko Reduced/Irradiated
 ;;12732,"KEY")
 ;;OR VBECS REASON FOR REQUEST^5
 ;;12732,"VAL")
 ;;Transfuse
 ;;12733,"KEY")
 ;;OR VBECS REASON FOR REQUEST^10
 ;;12733,"VAL")
 ;;Hold for OR
 ;;12734,"KEY")
 ;;OR VBECS REASON FOR REQUEST^15
 ;;12734,"VAL")
 ;;Hold until MD gives order
 ;;12735,"KEY")
 ;;OR VBECS REASON FOR REQUEST^20
 ;;12735,"VAL")
 ;;See COMMENT for justification
 ;;13450,"KEY")
 ;;OR VBECS ON^1
 ;;13450,"VAL")
 ;;YES
 ;;13561,"KEY")
 ;;OR VBECS ERROR MESSAGE^1
 ;;13561,"VAL")
 ;;Default VistaLink Error
 ;;13561,"VAL",1,0)
 ;;******************************************************************
 ;;13561,"VAL",2,0)
 ;;*                                                                *
 ;;13561,"VAL",3,0)
 ;;*          Patient data is not available at this time            *
 ;;13561,"VAL",4,0)
 ;;*            due to a VistALink connection failure.              *
 ;;13561,"VAL",5,0)
 ;;*                                                                *
 ;;13561,"VAL",6,0)
 ;;*       Contact IRM and/or the Blood Bank for assistance.        *
 ;;13561,"VAL",7,0)
 ;;*                                                                *
 ;;13561,"VAL",8,0)
 ;;******************************************************************
