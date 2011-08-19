SCAPMC8A ;bp/cmf - Build "ALL" array for $$PRTP^SCAPCM8 ;13 June 1999
 ;;5.3;Scheduling;**177,204**;AUG 13, 1993
 ;
TPALL(SCFILE) ;
 N SCD1,SCD0,SCAN,SCX,SCIEN,SCFLD
 N SCP1,SCP2,SCP3,SCP4,SCP5,SCP6,SCP7
 ;
 G:'$D(^SCTM(SCFILE,"B",SCTP)) TPQUIT
 S SCD1=@SCDATES@("BEGIN")                  ;begin date range
 S SCD0=@SCDATES@("END")                    ;end date range
 ;
LOOP S SCAN=0                                   ;incrementor
 S SCP7=0                                   ;pos asgn ien
 F  S SCP7=$O(^SCTM(SCFILE,"B",SCTP,SCP7)) Q:'SCP7  D
 . N SCX,SCP1,SCP2,SCP3,SCP4,SCP5,SCP6
 . Q:'$D(^SCTM(SCFILE,SCP7,0))
 . S SCIEN=SCP7_","
 . S SCFLD=$S(SCFILE=404.52:".02;.03;.04",1:".02;.04;.06")
 . D GETS^DIQ(SCFILE,SCIEN,SCFLD,"IE","SCX")
 . Q:'$D(SCX)
 . S SCP3=$G(SCX(SCFILE,SCIEN,.02,"I"))         ;pos asgn date int
 . Q:(SCP3<SCD1)!(SCP3>SCD0)
 . S SCAN=SCAN+1
 . S SCP1=$G(SCX(SCFILE,SCIEN,.04,"I"))         ;status int code
 . S SCP2=$G(SCX(SCFILE,SCIEN,.04,"E"))         ;status ext form
 . S SCP4=$G(SCX(SCFILE,SCIEN,.02,"E"))         ;pos asgn date ext
 . D:SCFILE=404.52
 . . S SCP5=$G(SCX(SCFILE,SCIEN,.03,"I"))         ;practition ien
 . . S SCP6=$G(SCX(SCFILE,SCIEN,.03,"E"))         ;practitioner name
 . . Q
 . D:SCFILE=404.53
 . . S SCP5=$G(SCX(SCFILE,SCIEN,.06,"I"))         ;precept posn ien
 . . S SCP6=$G(SCX(SCFILE,SCIEN,.06,"E"))         ;precept posn name
 . . Q
 . S @SCLIST@("ALL",SCFILE,0)=SCAN
 . S @SCLIST@("ALL",SCFILE,SCAN)=SCP1_U_SCP2_U_SCP3_U_SCP4_U_SCP5_U_SCP6_U_SCP7
 ;
TPQUIT Q
 ;
