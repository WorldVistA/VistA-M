IBDEI021 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2324,1,3,0)
 ;;=3^Rehabilitation Procedure NEC
 ;;^UTILITY(U,$J,358.3,2324,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,2324,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,2325,0)
 ;;=D64.9^^12^104^37
 ;;^UTILITY(U,$J,358.3,2325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2325,1,3,0)
 ;;=3^Anemia, unspec
 ;;^UTILITY(U,$J,358.3,2325,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,2325,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,2326,0)
 ;;=D86.9^^12^104^220
 ;;^UTILITY(U,$J,358.3,2326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2326,1,3,0)
 ;;=3^Sarcoidosis, unspec
 ;;^UTILITY(U,$J,358.3,2326,1,4,0)
 ;;=4^D86.9
 ;;^UTILITY(U,$J,358.3,2326,2)
 ;;=^5002454
 ;;^UTILITY(U,$J,358.3,2327,0)
 ;;=E55.9^^12^104^303
 ;;^UTILITY(U,$J,358.3,2327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2327,1,3,0)
 ;;=3^Vitamin D deficiency, unspec
 ;;^UTILITY(U,$J,358.3,2327,1,4,0)
 ;;=4^E55.9
 ;;^UTILITY(U,$J,358.3,2327,2)
 ;;=^5002799
 ;;^UTILITY(U,$J,358.3,2328,0)
 ;;=G56.91^^12^104^192
 ;;^UTILITY(U,$J,358.3,2328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2328,1,3,0)
 ;;=3^Mononeuropathy of rt upr limb, unspec
 ;;^UTILITY(U,$J,358.3,2328,1,4,0)
 ;;=4^G56.91
 ;;^UTILITY(U,$J,358.3,2328,2)
 ;;=^5004036
 ;;^UTILITY(U,$J,358.3,2329,0)
 ;;=G56.92^^12^104^191
 ;;^UTILITY(U,$J,358.3,2329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2329,1,3,0)
 ;;=3^Mononeuropathy of lft upr limb, unspec
 ;;^UTILITY(U,$J,358.3,2329,1,4,0)
 ;;=4^G56.92
 ;;^UTILITY(U,$J,358.3,2329,2)
 ;;=^5004037
 ;;^UTILITY(U,$J,358.3,2330,0)
 ;;=M30.0^^12^104^200
 ;;^UTILITY(U,$J,358.3,2330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2330,1,3,0)
 ;;=3^Polyarteritis nodosa
 ;;^UTILITY(U,$J,358.3,2330,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,2330,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,2331,0)
 ;;=M35.9^^12^104^281
 ;;^UTILITY(U,$J,358.3,2331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2331,1,3,0)
 ;;=3^Systemic involvement of connective tissue, unspec
 ;;^UTILITY(U,$J,358.3,2331,1,4,0)
 ;;=4^M35.9
 ;;^UTILITY(U,$J,358.3,2331,2)
 ;;=^5011797
 ;;^UTILITY(U,$J,358.3,2332,0)
 ;;=M45.9^^12^104^47
 ;;^UTILITY(U,$J,358.3,2332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2332,1,3,0)
 ;;=3^Ankylosing spondylitis unspec sites in spine
 ;;^UTILITY(U,$J,358.3,2332,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,2332,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,2333,0)
 ;;=M45.0^^12^104^42
 ;;^UTILITY(U,$J,358.3,2333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2333,1,3,0)
 ;;=3^Ankylosing spondylitis mltpl sites in spine
 ;;^UTILITY(U,$J,358.3,2333,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,2333,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,2334,0)
 ;;=M45.1^^12^104^43
 ;;^UTILITY(U,$J,358.3,2334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2334,1,3,0)
 ;;=3^Ankylosing spondylitis occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,2334,1,4,0)
 ;;=4^M45.1
 ;;^UTILITY(U,$J,358.3,2334,2)
 ;;=^5011961
 ;;^UTILITY(U,$J,358.3,2335,0)
 ;;=M45.2^^12^104^38
 ;;^UTILITY(U,$J,358.3,2335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2335,1,3,0)
 ;;=3^Ankylosing spondylitis cervical region
 ;;^UTILITY(U,$J,358.3,2335,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,2335,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,2336,0)
 ;;=M45.3^^12^104^39
 ;;^UTILITY(U,$J,358.3,2336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2336,1,3,0)
 ;;=3^Ankylosing spondylitis crvicothrcic region
 ;;^UTILITY(U,$J,358.3,2336,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,2336,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,2337,0)
 ;;=M45.4^^12^104^45
 ;;^UTILITY(U,$J,358.3,2337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2337,1,3,0)
 ;;=3^Ankylosing spondylitis thoracic region
 ;;^UTILITY(U,$J,358.3,2337,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,2337,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,2338,0)
 ;;=M45.5^^12^104^46
 ;;^UTILITY(U,$J,358.3,2338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2338,1,3,0)
 ;;=3^Ankylosing spondylitis thoracolumbar regn
 ;;^UTILITY(U,$J,358.3,2338,1,4,0)
 ;;=4^M45.5
 ;;^UTILITY(U,$J,358.3,2338,2)
 ;;=^5011965
 ;;^UTILITY(U,$J,358.3,2339,0)
 ;;=M45.6^^12^104^40
 ;;^UTILITY(U,$J,358.3,2339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2339,1,3,0)
 ;;=3^Ankylosing spondylitis lumbar region
 ;;^UTILITY(U,$J,358.3,2339,1,4,0)
 ;;=4^M45.6
 ;;^UTILITY(U,$J,358.3,2339,2)
 ;;=^5011966
 ;;^UTILITY(U,$J,358.3,2340,0)
 ;;=M45.7^^12^104^41
 ;;^UTILITY(U,$J,358.3,2340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2340,1,3,0)
 ;;=3^Ankylosing spondylitis lumbosacral region
 ;;^UTILITY(U,$J,358.3,2340,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,2340,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,2341,0)
 ;;=M45.8^^12^104^44
 ;;^UTILITY(U,$J,358.3,2341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2341,1,3,0)
 ;;=3^Ankylosing spondylitis sacral & scrococygl regn
 ;;^UTILITY(U,$J,358.3,2341,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,2341,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,2342,0)
 ;;=M46.00^^12^104^234
 ;;^UTILITY(U,$J,358.3,2342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2342,1,3,0)
 ;;=3^Spinal enthesopathy, site unspec
 ;;^UTILITY(U,$J,358.3,2342,1,4,0)
 ;;=4^M46.00
 ;;^UTILITY(U,$J,358.3,2342,2)
 ;;=^5011970
 ;;^UTILITY(U,$J,358.3,2343,0)
 ;;=M46.01^^12^104^232
 ;;^UTILITY(U,$J,358.3,2343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2343,1,3,0)
 ;;=3^Spinal enthesopathy, occipito-atlanto-axial regn
 ;;^UTILITY(U,$J,358.3,2343,1,4,0)
 ;;=4^M46.01
 ;;^UTILITY(U,$J,358.3,2343,2)
 ;;=^5011971
 ;;^UTILITY(U,$J,358.3,2344,0)
 ;;=M46.02^^12^104^228
 ;;^UTILITY(U,$J,358.3,2344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2344,1,3,0)
 ;;=3^Spinal enthesopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2344,1,4,0)
 ;;=4^M46.02
 ;;^UTILITY(U,$J,358.3,2344,2)
 ;;=^5011972
 ;;^UTILITY(U,$J,358.3,2345,0)
 ;;=M46.03^^12^104^229
 ;;^UTILITY(U,$J,358.3,2345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2345,1,3,0)
 ;;=3^Spinal enthesopathy, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,2345,1,4,0)
 ;;=4^M46.03
 ;;^UTILITY(U,$J,358.3,2345,2)
 ;;=^5011973
 ;;^UTILITY(U,$J,358.3,2346,0)
 ;;=M46.04^^12^104^235
 ;;^UTILITY(U,$J,358.3,2346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2346,1,3,0)
 ;;=3^Spinal enthesopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,2346,1,4,0)
 ;;=4^M46.04
 ;;^UTILITY(U,$J,358.3,2346,2)
 ;;=^5011974
 ;;^UTILITY(U,$J,358.3,2347,0)
 ;;=M46.05^^12^104^236
 ;;^UTILITY(U,$J,358.3,2347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2347,1,3,0)
 ;;=3^Spinal enthesopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,2347,1,4,0)
 ;;=4^M46.05
 ;;^UTILITY(U,$J,358.3,2347,2)
 ;;=^5011975
 ;;^UTILITY(U,$J,358.3,2348,0)
 ;;=M46.06^^12^104^230
 ;;^UTILITY(U,$J,358.3,2348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2348,1,3,0)
 ;;=3^Spinal enthesopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,2348,1,4,0)
 ;;=4^M46.06
 ;;^UTILITY(U,$J,358.3,2348,2)
 ;;=^5011976
 ;;^UTILITY(U,$J,358.3,2349,0)
 ;;=M46.07^^12^104^231
 ;;^UTILITY(U,$J,358.3,2349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2349,1,3,0)
 ;;=3^Spinal enthesopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,2349,1,4,0)
 ;;=4^M46.07
 ;;^UTILITY(U,$J,358.3,2349,2)
 ;;=^5011977
 ;;^UTILITY(U,$J,358.3,2350,0)
 ;;=M46.08^^12^104^233
 ;;^UTILITY(U,$J,358.3,2350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2350,1,3,0)
 ;;=3^Spinal enthesopathy, sacral & sacrococcygeal regn
 ;;^UTILITY(U,$J,358.3,2350,1,4,0)
 ;;=4^M46.08
 ;;^UTILITY(U,$J,358.3,2350,2)
 ;;=^5011978
 ;;^UTILITY(U,$J,358.3,2351,0)
 ;;=M46.1^^12^104^219
 ;;^UTILITY(U,$J,358.3,2351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2351,1,3,0)
 ;;=3^Sacroiliitis, NEC
 ;;^UTILITY(U,$J,358.3,2351,1,4,0)
 ;;=4^M46.1
 ;;^UTILITY(U,$J,358.3,2351,2)
 ;;=^5011980
 ;;^UTILITY(U,$J,358.3,2352,0)
 ;;=M49.80^^12^104^251
 ;;^UTILITY(U,$J,358.3,2352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2352,1,3,0)
 ;;=3^Spondylopathy Site Unspec
 ;;^UTILITY(U,$J,358.3,2352,1,4,0)
 ;;=4^M49.80
 ;;^UTILITY(U,$J,358.3,2352,2)
 ;;=^5012205
 ;;^UTILITY(U,$J,358.3,2353,0)
 ;;=M49.81^^12^104^249
 ;;^UTILITY(U,$J,358.3,2353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2353,1,3,0)
 ;;=3^Spondylopathy Occipt-Atlan-Ax Region
 ;;^UTILITY(U,$J,358.3,2353,1,4,0)
 ;;=4^M49.81
 ;;^UTILITY(U,$J,358.3,2353,2)
 ;;=^5012206
 ;;^UTILITY(U,$J,358.3,2354,0)
 ;;=M49.82^^12^104^245
 ;;^UTILITY(U,$J,358.3,2354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2354,1,3,0)
 ;;=3^Spondylopathy Cervical Region
 ;;^UTILITY(U,$J,358.3,2354,1,4,0)
 ;;=4^M49.82
 ;;^UTILITY(U,$J,358.3,2354,2)
 ;;=^5012207
 ;;^UTILITY(U,$J,358.3,2355,0)
 ;;=M49.83^^12^104^246
 ;;^UTILITY(U,$J,358.3,2355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2355,1,3,0)
 ;;=3^Spondylopathy Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,2355,1,4,0)
 ;;=4^M49.83
 ;;^UTILITY(U,$J,358.3,2355,2)
 ;;=^5012208
 ;;^UTILITY(U,$J,358.3,2356,0)
 ;;=M49.84^^12^104^252
 ;;^UTILITY(U,$J,358.3,2356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2356,1,3,0)
 ;;=3^Spondylopathy Thoracic Region
 ;;^UTILITY(U,$J,358.3,2356,1,4,0)
 ;;=4^M49.84
 ;;^UTILITY(U,$J,358.3,2356,2)
 ;;=^5012209
 ;;^UTILITY(U,$J,358.3,2357,0)
 ;;=M49.85^^12^104^253
 ;;^UTILITY(U,$J,358.3,2357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2357,1,3,0)
 ;;=3^Spondylopathy Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,2357,1,4,0)
 ;;=4^M49.85
 ;;^UTILITY(U,$J,358.3,2357,2)
 ;;=^5012210
 ;;^UTILITY(U,$J,358.3,2358,0)
 ;;=M49.86^^12^104^247
 ;;^UTILITY(U,$J,358.3,2358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2358,1,3,0)
 ;;=3^Spondylopathy Lumbar Region
 ;;^UTILITY(U,$J,358.3,2358,1,4,0)
 ;;=4^M49.86
 ;;^UTILITY(U,$J,358.3,2358,2)
 ;;=^5012211
 ;;^UTILITY(U,$J,358.3,2359,0)
 ;;=M49.87^^12^104^248
 ;;^UTILITY(U,$J,358.3,2359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2359,1,3,0)
 ;;=3^Spondylopathy Lumboscrl Region
 ;;^UTILITY(U,$J,358.3,2359,1,4,0)
 ;;=4^M49.87
 ;;^UTILITY(U,$J,358.3,2359,2)
 ;;=^5012212
 ;;^UTILITY(U,$J,358.3,2360,0)
 ;;=M49.88^^12^104^250
