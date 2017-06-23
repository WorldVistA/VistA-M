SDECU4 ;ALB/JSM - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
GETFONT(VAL,ENT) ; returns default font size
 N FNT
 S ENT=$G(ENT)
 ;S:ENT="" ENT="SYS"
 S:ENT="" ENT="DIV"
 S VAL="^TMP(""SDECRMGP"","_$J_",""FONTSIZE"")"
 K @VAL
 ; data header
 S @VAL@(0)="T00030RETURNCODE^T00050TEXT"_$C(30)
 ;
 S FNT=$$GET^XPAR(ENT,"SDEC DEFAULT FONT SIZE",1,"I")
 S @VAL@(1)=FNT_$C(30,31)
 Q
 ;
PUTFONT(RET,ENT,VAL)      ; save the default font size
 N ERR
 S ENT=$G(ENT)
 ;S:ENT="" ENT="SYS"
 S:ENT="" ENT="DIV"
 S RET="^TMP(""SDECRMGP"","_$J_",""FONTSIZE"")"
 K @RET
 ; data header
 S @RET@(0)="T00030RETURNCODE^T00050TEXT"_$C(30)
 I VAL="" S @RET@(1)="-1^Default font size not provided"_$C(30,31) Q    ; quit if value is not set
 D EN^XPAR(ENT,"SDEC DEFAULT FONT SIZE",1,VAL,.ERR)
 I ERR S @RET@(1)="-1^FILTER ERR: "_$P(ERR,U,1)_";"_$P(ERR,U,2)_$C(30,31) Q
 S @RET@(1)="0^SUCCESS"_$C(30,31)
 Q
 ;
