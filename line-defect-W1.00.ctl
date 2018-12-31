;---------------------------------------------------------------------------------------------------------
; This .ctl file is to calculate dispersion curve of photonic crystal (PhC) waveguide using 3D simulation.
; The PhC slab is composed of air holes with triangular lattice in silicon.                               
; The PhC waveguide is formed by removing one row of air holes (W1.00). It is cladded with air.                                  
; Written by Yuyang ZHUANG.                                                                               
; Tanabe Lab at Keio University.                                                                          
; 2018/12/31.                                                                                              
;---------------------------------------------------------------------------------------------------------

; Define global variables.
(define a 420)              ; lattice constant 420 nm
(define r (/ 122 a))        ; radius of air hole 122 nm
(define t (/ 210 a))        ; thickness of PhC slab 210 nm
(define eps1 (expt 3.47 2)) ; epsilon of silicon (Si) at 1550 nm
(define eps2 (expt 1 2))    ; epsilon of air
(define w 1.00)             ; width factor of PhC waveguide (W1.00)

; Step 1: Set calculating band numbers.
(set! num-bands 20)

; Step 2: Set geometry of super-cell.
(set! geometry-lattice (make lattice (size 1 19 2) ; super-cell size is 1*19*2.
                       (basis1 (/ (sqrt 3) 2) 0.5)
                       (basis2 (/ (sqrt 3) 2) -0.5)
		               (basis3 0 0 1)
))

; Step 3: Set k-points.
(define Gamma (vector3 0 0 0))
(define K' (vector3 0.5 0 0)) ; edge of Brillouin zone.
(set! k-points (interpolate 19 (list Gamma K'))) ; interpolate k-points, time-consuming with a large number.

; Step 4.1: Set background material as air.
(set! default-material (make dielectric (epsilon eps2)))

; Step 4.2: Set geometry of the PhC waveguide. 
(set! geometry (list  
	; Si slab.
		(make block (center 0 0 0) (size infinity infinity t)  (material (make dielectric (epsilon eps1))))
	; air holes.
	; upper
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 1 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 2 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 3 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 4 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 5 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 6 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 7 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 8 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (- 0 (/ (- w 1) 2)) (+ 9 (+ (- w 1)))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
	; lower
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 1 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 2 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 3 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 4 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 5 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 6 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 7 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 8 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center (/ (- w 1) 2) (- 0 (+ 9 (+ (- w 1))))) (radius r)   (height t)    (material (make dielectric (epsilon eps2))))			
))

; Step 5: Set resolution.
(set! resolution 16)

; Step 6: Run even mode.
(run-zeven)

; End
