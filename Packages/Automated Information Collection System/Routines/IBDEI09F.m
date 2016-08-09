IBDEI09F ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9392,1,4,0)
 ;;=4^H61.23
 ;;^UTILITY(U,$J,358.3,9392,2)
 ;;=^5006533
 ;;^UTILITY(U,$J,358.3,9393,0)
 ;;=H61.21^^48^556^31
 ;;^UTILITY(U,$J,358.3,9393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9393,1,3,0)
 ;;=3^Impacted cerumen, right ear
 ;;^UTILITY(U,$J,358.3,9393,1,4,0)
 ;;=4^H61.21
 ;;^UTILITY(U,$J,358.3,9393,2)
 ;;=^5006531
 ;;^UTILITY(U,$J,358.3,9394,0)
 ;;=H61.22^^48^556^30
 ;;^UTILITY(U,$J,358.3,9394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9394,1,3,0)
 ;;=3^Impacted cerumen, left ear
 ;;^UTILITY(U,$J,358.3,9394,1,4,0)
 ;;=4^H61.22
 ;;^UTILITY(U,$J,358.3,9394,2)
 ;;=^5006532
 ;;^UTILITY(U,$J,358.3,9395,0)
 ;;=H68.101^^48^556^25
 ;;^UTILITY(U,$J,358.3,9395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9395,1,3,0)
 ;;=3^Eustachian Tube Obstruction,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,9395,1,4,0)
 ;;=4^H68.101
 ;;^UTILITY(U,$J,358.3,9395,2)
 ;;=^5006658
 ;;^UTILITY(U,$J,358.3,9396,0)
 ;;=H68.102^^48^556^24
 ;;^UTILITY(U,$J,358.3,9396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9396,1,3,0)
 ;;=3^Eustachian Tube Obstruction,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,9396,1,4,0)
 ;;=4^H68.102
 ;;^UTILITY(U,$J,358.3,9396,2)
 ;;=^5006659
 ;;^UTILITY(U,$J,358.3,9397,0)
 ;;=H68.103^^48^556^23
 ;;^UTILITY(U,$J,358.3,9397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9397,1,3,0)
 ;;=3^Eustachian Tube Obstruction,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,9397,1,4,0)
 ;;=4^H68.103
 ;;^UTILITY(U,$J,358.3,9397,2)
 ;;=^5006660
 ;;^UTILITY(U,$J,358.3,9398,0)
 ;;=H70.11^^48^556^16
 ;;^UTILITY(U,$J,358.3,9398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9398,1,3,0)
 ;;=3^Chronic mastoiditis, right ear
 ;;^UTILITY(U,$J,358.3,9398,1,4,0)
 ;;=4^H70.11
 ;;^UTILITY(U,$J,358.3,9398,2)
 ;;=^5006698
 ;;^UTILITY(U,$J,358.3,9399,0)
 ;;=H70.12^^48^556^15
 ;;^UTILITY(U,$J,358.3,9399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9399,1,3,0)
 ;;=3^Chronic mastoiditis, left ear
 ;;^UTILITY(U,$J,358.3,9399,1,4,0)
 ;;=4^H70.12
 ;;^UTILITY(U,$J,358.3,9399,2)
 ;;=^5006699
 ;;^UTILITY(U,$J,358.3,9400,0)
 ;;=H83.01^^48^556^36
 ;;^UTILITY(U,$J,358.3,9400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9400,1,3,0)
 ;;=3^Labyrinthitis, right ear
 ;;^UTILITY(U,$J,358.3,9400,1,4,0)
 ;;=4^H83.01
 ;;^UTILITY(U,$J,358.3,9400,2)
 ;;=^5006894
 ;;^UTILITY(U,$J,358.3,9401,0)
 ;;=H83.02^^48^556^35
 ;;^UTILITY(U,$J,358.3,9401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9401,1,3,0)
 ;;=3^Labyrinthitis, left ear
 ;;^UTILITY(U,$J,358.3,9401,1,4,0)
 ;;=4^H83.02
 ;;^UTILITY(U,$J,358.3,9401,2)
 ;;=^5006895
 ;;^UTILITY(U,$J,358.3,9402,0)
 ;;=H73.001^^48^556^4
 ;;^UTILITY(U,$J,358.3,9402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9402,1,3,0)
 ;;=3^Acute myringitis, right ear
 ;;^UTILITY(U,$J,358.3,9402,1,4,0)
 ;;=4^H73.001
 ;;^UTILITY(U,$J,358.3,9402,2)
 ;;=^5006763
 ;;^UTILITY(U,$J,358.3,9403,0)
 ;;=H73.002^^48^556^3
 ;;^UTILITY(U,$J,358.3,9403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9403,1,3,0)
 ;;=3^Acute myringitis, left ear
 ;;^UTILITY(U,$J,358.3,9403,1,4,0)
 ;;=4^H73.002
 ;;^UTILITY(U,$J,358.3,9403,2)
 ;;=^5006764
 ;;^UTILITY(U,$J,358.3,9404,0)
 ;;=H71.91^^48^556^14
 ;;^UTILITY(U,$J,358.3,9404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9404,1,3,0)
 ;;=3^Cholesteatoma, right ear,Unspec
 ;;^UTILITY(U,$J,358.3,9404,1,4,0)
 ;;=4^H71.91
 ;;^UTILITY(U,$J,358.3,9404,2)
 ;;=^5006739
 ;;^UTILITY(U,$J,358.3,9405,0)
 ;;=H71.92^^48^556^13
 ;;^UTILITY(U,$J,358.3,9405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9405,1,3,0)
 ;;=3^Cholesteatoma, left ear,Unspec
 ;;^UTILITY(U,$J,358.3,9405,1,4,0)
 ;;=4^H71.92
 ;;^UTILITY(U,$J,358.3,9405,2)
 ;;=^5006740
 ;;^UTILITY(U,$J,358.3,9406,0)
 ;;=H91.21^^48^556^57
 ;;^UTILITY(U,$J,358.3,9406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9406,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, right ear
 ;;^UTILITY(U,$J,358.3,9406,1,4,0)
 ;;=4^H91.21
 ;;^UTILITY(U,$J,358.3,9406,2)
 ;;=^5006937
 ;;^UTILITY(U,$J,358.3,9407,0)
 ;;=H91.22^^48^556^56
 ;;^UTILITY(U,$J,358.3,9407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9407,1,3,0)
 ;;=3^Sudden idiopathic hearing loss, left ear
 ;;^UTILITY(U,$J,358.3,9407,1,4,0)
 ;;=4^H91.22
 ;;^UTILITY(U,$J,358.3,9407,2)
 ;;=^5006938
 ;;^UTILITY(U,$J,358.3,9408,0)
 ;;=H90.0^^48^556^21
 ;;^UTILITY(U,$J,358.3,9408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9408,1,3,0)
 ;;=3^Conductive hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,9408,1,4,0)
 ;;=4^H90.0
 ;;^UTILITY(U,$J,358.3,9408,2)
 ;;=^335257
 ;;^UTILITY(U,$J,358.3,9409,0)
 ;;=H90.11^^48^556^20
 ;;^UTILITY(U,$J,358.3,9409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9409,1,3,0)
 ;;=3^Condctv hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,9409,1,4,0)
 ;;=4^H90.11
 ;;^UTILITY(U,$J,358.3,9409,2)
 ;;=^5006918
 ;;^UTILITY(U,$J,358.3,9410,0)
 ;;=H90.12^^48^556^19
 ;;^UTILITY(U,$J,358.3,9410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9410,1,3,0)
 ;;=3^Condctv hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,9410,1,4,0)
 ;;=4^H90.12
 ;;^UTILITY(U,$J,358.3,9410,2)
 ;;=^5006919
 ;;^UTILITY(U,$J,358.3,9411,0)
 ;;=H90.3^^48^556^53
 ;;^UTILITY(U,$J,358.3,9411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9411,1,3,0)
 ;;=3^Sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,9411,1,4,0)
 ;;=4^H90.3
 ;;^UTILITY(U,$J,358.3,9411,2)
 ;;=^335328
 ;;^UTILITY(U,$J,358.3,9412,0)
 ;;=H90.41^^48^556^55
 ;;^UTILITY(U,$J,358.3,9412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9412,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, right ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,9412,1,4,0)
 ;;=4^H90.41
 ;;^UTILITY(U,$J,358.3,9412,2)
 ;;=^5006921
 ;;^UTILITY(U,$J,358.3,9413,0)
 ;;=H90.42^^48^556^54
 ;;^UTILITY(U,$J,358.3,9413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9413,1,3,0)
 ;;=3^Snsrnrl hear loss, uni, left ear, w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,9413,1,4,0)
 ;;=4^H90.42
 ;;^UTILITY(U,$J,358.3,9413,2)
 ;;=^5006922
 ;;^UTILITY(U,$J,358.3,9414,0)
 ;;=H90.6^^48^556^44
 ;;^UTILITY(U,$J,358.3,9414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9414,1,3,0)
 ;;=3^Mixed conductive and sensorineural hearing loss, bilateral
 ;;^UTILITY(U,$J,358.3,9414,1,4,0)
 ;;=4^H90.6
 ;;^UTILITY(U,$J,358.3,9414,2)
 ;;=^5006924
 ;;^UTILITY(U,$J,358.3,9415,0)
 ;;=H90.71^^48^556^43
 ;;^UTILITY(U,$J,358.3,9415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9415,1,3,0)
 ;;=3^Mix cndct/snrl hear loss,uni,r ear,w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,9415,1,4,0)
 ;;=4^H90.71
 ;;^UTILITY(U,$J,358.3,9415,2)
 ;;=^5006925
 ;;^UTILITY(U,$J,358.3,9416,0)
 ;;=H90.72^^48^556^42
 ;;^UTILITY(U,$J,358.3,9416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9416,1,3,0)
 ;;=3^Mix cndct/snrl hear loss,uni,l ear,w unrestr hear cntra side
 ;;^UTILITY(U,$J,358.3,9416,1,4,0)
 ;;=4^H90.72
 ;;^UTILITY(U,$J,358.3,9416,2)
 ;;=^5006926
 ;;^UTILITY(U,$J,358.3,9417,0)
 ;;=H61.001^^48^556^50
 ;;^UTILITY(U,$J,358.3,9417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9417,1,3,0)
 ;;=3^Perichondritis of right external ear
 ;;^UTILITY(U,$J,358.3,9417,1,4,0)
 ;;=4^H61.001
 ;;^UTILITY(U,$J,358.3,9417,2)
 ;;=^5006499
 ;;^UTILITY(U,$J,358.3,9418,0)
 ;;=H61.002^^48^556^49
 ;;^UTILITY(U,$J,358.3,9418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9418,1,3,0)
 ;;=3^Perichondritis of left external ear
 ;;^UTILITY(U,$J,358.3,9418,1,4,0)
 ;;=4^H61.002
 ;;^UTILITY(U,$J,358.3,9418,2)
 ;;=^5006500
 ;;^UTILITY(U,$J,358.3,9419,0)
 ;;=H65.111^^48^556^8
 ;;^UTILITY(U,$J,358.3,9419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9419,1,3,0)
 ;;=3^Acute/subacute allergic otitis media, r ear
 ;;^UTILITY(U,$J,358.3,9419,1,4,0)
 ;;=4^H65.111
 ;;^UTILITY(U,$J,358.3,9419,2)
 ;;=^5006577
 ;;^UTILITY(U,$J,358.3,9420,0)
 ;;=H65.112^^48^556^7
 ;;^UTILITY(U,$J,358.3,9420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9420,1,3,0)
 ;;=3^Acute/subacute allergic otitis media, left ear
