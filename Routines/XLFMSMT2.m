XLFMSMT2 ;SLC,SF/MH,RWF - functions for conversion in measurment ;12/12/94  12:18
 ;;8.0;KERNEL;;Jul 10, 1995
WT I FROM=TO Q VAL_" "_TO
 ; common metric unit is kilograms KG
 I $P("^T^1^KG^1^G^1^MG^1",CKY,2) S VAL=VAL*$P("^T^1000^KG^1^G^.001^MG^.000001",CKY,2) S VAL=VAL_"M"
 ; common english unit is pound LB
 I $P("^TN^1^LB^1^OZ^1^GR^1",CKY,2) S VAL=VAL*$P("^TN^2000^LB^1^OZ^.0625^GR^.0001302083",CKY,2) S VAL=VAL_"U"
 ; the result of the above 2 IF statments will result in VAL being
 ; converted to kilograms or pounds depending on the value of FROM
 ;
 ; VAL in metric and will convert to metric VAL in KG
 I VAL["M",$P("^T^1^KG^1^G^1^MG^1",CKZ,2) S VAL=VAL*$P("^T^.00001^KG^1^G^1000^MG^10000",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in U.S. and will convert to U.S. VAL in LB
 I VAL["U",$P("^TN^1^LB^1^OZ^1^GR^1",CKZ,2) S VAL=VAL*$P("^TN^.0005^LB^1^OZ^16^GR^7680",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in U.S. and will convert to metric VAL in LB
 I VAL["U",$P("^T^1^KG^1^G^1^MG^1",CKZ,2) S VAL=VAL*$P("^T^.000454^KG^.454^G^454^MG^454000",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in metric and will convert to U.S. VAL in KG
 I VAL["M",$P("^TN^1^LB^1^OZ^1^GR^1",CKZ,2) S VAL=VAL*$P("^TN^.0011023^LB^2.2046^OZ^35.2736^GR^154300",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
LN ;
 ; -***- common metric unit is centimeters CM -***-
 I $P("^KM^1^M^1^CM^1^MM^1",CKY,2) S VAL=VAL*+$P("^KM^100000^M^100^CM^1^MM^.1",CKY,2)_"M"
 ;
 ; -***- common U.S. unit is inches IN -***-
 I $P("^MI^1^YD^1^FT^1^IN^1",CKY,2) S VAL=VAL*$P("^MI^63360^YD^36^FT^12^IN^1",CKY,2)_"U"
 ;
 ; VAL in metric (cm) and will convert to metric
 I VAL["M",$P("^KM^1^M^1^CM^1^MM^1",CKZ,2) S VAL=VAL*$P("^KM^.001^M^.01^CM^1^MM^10^",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in U.S. and will convert to U.S.
 I VAL["U",$P("^MI^1^YD^1^FT^1^IN^1",CKZ,2) S VAL=VAL*$P("^MI^.0000157085^YD^.0277777778^FT^.0833333333^IN^1",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in U.S. and will convert to metric
 I VAL["U",$P("^KM^1^M^1^CM^1^MM^1",CKZ,2) S VAL=VAL*$P("^KM^.0000254^M^.0254^CM^2.540^MM^25.4",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in metric (cm) and will convert to U.S.
 I VAL["M",$P("^MI^1^YD^1^FT^1^IN^1",CKZ,2) S VAL=VAL*$P("^MI^.0000062^YD^.010936^FT^.032808^IN^.393696",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
VOL ; common metric unit = mililiter ML
 I $P("^KL^1^HL^1^DAL^1^L^1^DL^1^CL^1^ML^1^",CKY,2) S VAL=VAL*+$P("^KL^1000000^HL^100000^DAL^10000^L^1000^DL^100^CL^10^ML^1",CKY,2)_"M"
 ; common U.S. unit = cubic inches CI
 I $P("^CF^1^CI^1^GAL^1^QT^1^PT^1^C^1^OZ^1",CKY,2) S VAL=VAL*+$P("^CF^1728^CI^1^GAL^231^QT^57.75^PT^28.875^C^14.4375^OZ^1.805",CKY,2)_"U"
 ;
 ; VAL in U.S. (cubic inches) and will convert to metric
 I VAL["U",$P("^KL^1^HL^1^DAL^1^L^1^DL^1^CL^1^ML^1^",CKZ,2) S VAL=VAL*+$P("^KL^.000016387^HL^.00016387^DAL^.0016387^L^.016387^DL^.16387^CL^1.6387^ML^16.387^",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in metric (mililiter) and will convert to U.S.
 I VAL["M",$P("^CF^1^CI^1^GAL^1^QT^1^PT^1^C^1^OZ^1",CKZ,2) S VAL=VAL*+$P("^CF^.00003531^CI^.0610^GAL^.0002642^QT^.0010568^PT^.0021136^C^.0042272^OZ^.033818^",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in metric (mililiter) and will convert to metric
 I VAL["M",$P("^KL^1^HL^1^DAL^1^L^1^CL^1^DL^1^ML^1",CKZ,2) S VAL=VAL*+$P("^KL^.000001^HL^.00001^DAL^.0001^L^.001^DL^.01^CL^.1^ML^1",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 ;
 ; VAL in U.S. (cubic inches) and will convert to U.S.
 I VAL["U",$P("^CF^1^CI^1^GAL^1^QT^1^PT^1^C^1^OZ^1",CKZ,2) S VAL=VAL*+$P("^CF^.0005787^CI^1^GAL^.004329^QT^.017316^PT^.034632^C^.069264^OZ^.554017",CKZ,2) Q $$FORMAT(VAL)_" "_TO
 Q "ERROR"
 ;
 ;
FORMAT(VAL) ;
 N % S %=3 I VAL<1 S %=$L(+VAL),%=$S(%>10:10,1:%)
 Q +$FN(VAL,"",%)
 ;
UPCASE(VAL) ;
 Q $TR(VAL,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
