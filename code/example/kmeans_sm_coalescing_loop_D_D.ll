; ModuleID = 'kmeans_sm_coalescing_loop_D_D.cl'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600"

@kmeans_kernel_c.l_clusters = internal addrspace(3) unnamed_addr global [1024 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define void @kmeans_kernel_c(float addrspace(1)* noalias nocapture readonly %feature, float addrspace(1)* noalias nocapture readonly %clusters, i32 addrspace(1)* noalias nocapture %membership, i32 %npoints, i32 %nclusters, i32 %nfeatures, i32 %offset, i32 %size) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = icmp ult i32 %2, %nclusters
  br i1 %3, label %4, label %17

; <label>:4                                       ; preds = %0
  %5 = shl i32 %2, 3
  %6 = getelementptr inbounds float addrspace(1)* %clusters, i32 %5
  %7 = getelementptr inbounds [1024 x float] addrspace(3)* @kmeans_kernel_c.l_clusters, i32 0, i32 %5
  %8 = bitcast float addrspace(1)* %6 to <4 x float> addrspace(1)*
  %9 = load <4 x float> addrspace(1)* %8, align 4, !tbaa !2
  %10 = bitcast float addrspace(3)* %7 to <4 x float> addrspace(3)*
  store <4 x float> %9, <4 x float> addrspace(3)* %10, align 4, !tbaa !2
  %11 = or i32 %5, 4
  %12 = getelementptr inbounds float addrspace(1)* %clusters, i32 %11
  %13 = getelementptr inbounds [1024 x float] addrspace(3)* @kmeans_kernel_c.l_clusters, i32 0, i32 %11
  %14 = bitcast float addrspace(1)* %12 to <4 x float> addrspace(1)*
  %15 = load <4 x float> addrspace(1)* %14, align 4, !tbaa !2
  %16 = bitcast float addrspace(3)* %13 to <4 x float> addrspace(3)*
  store <4 x float> %15, <4 x float> addrspace(3)* %16, align 4, !tbaa !2
  br label %17

; <label>:17                                      ; preds = %4, %0
  tail call void @barrier(i32 1) #2
  %18 = tail call i32 @get_global_size(i32 0) #2
  %19 = tail call i32 @get_global_id(i32 0) #2
  %20 = icmp ult i32 %19, %npoints
  br i1 %20, label %.preheader4.lr.ph, label %._crit_edge12

.preheader4.lr.ph:                                ; preds = %17
  %21 = icmp sgt i32 %nclusters, 0
  %22 = icmp sgt i32 %nfeatures, 0
  br label %.preheader4

.preheader4:                                      ; preds = %.preheader4.lr.ph, %._crit_edge8
  %point_id.011 = phi i32 [ %19, %.preheader4.lr.ph ], [ %39, %._crit_edge8 ]
  %index.010 = phi i32 [ 0, %.preheader4.lr.ph ], [ %index.1.lcssa, %._crit_edge8 ]
  br i1 %21, label %.preheader.lr.ph, label %._crit_edge8

.preheader.lr.ph:                                 ; preds = %.preheader4
  %23 = mul i32 %point_id.011, %nfeatures
  br label %.preheader

.preheader:                                       ; preds = %._crit_edge, %.preheader.lr.ph
  %index.17 = phi i32 [ %index.010, %.preheader.lr.ph ], [ %index.2, %._crit_edge ]
  %min_dist.06 = phi float [ 0x47EFFFFFE0000000, %.preheader.lr.ph ], [ %min_dist.1, %._crit_edge ]
  %i.05 = phi i32 [ 0, %.preheader.lr.ph ], [ %37, %._crit_edge ]
  br i1 %22, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %24 = mul nsw i32 %i.05, %nfeatures
  br label %25

; <label>:25                                      ; preds = %25, %.lr.ph
  %l.03 = phi i32 [ 0, %.lr.ph ], [ %35, %25 ]
  %ans.02 = phi float [ 0.000000e+00, %.lr.ph ], [ %34, %25 ]
  %26 = add nsw i32 %l.03, %24
  %27 = getelementptr inbounds [1024 x float] addrspace(3)* @kmeans_kernel_c.l_clusters, i32 0, i32 %26
  %28 = load float addrspace(3)* %27, align 4, !tbaa !2
  %29 = add i32 %l.03, %23
  %30 = getelementptr inbounds float addrspace(1)* %feature, i32 %29
  %31 = load float addrspace(1)* %30, align 4, !tbaa !2
  %32 = fsub float %31, %28
  %33 = fmul float %32, %32
  %34 = fadd float %ans.02, %33
  %35 = add nsw i32 %l.03, 1
  %exitcond = icmp eq i32 %35, %nfeatures
  br i1 %exitcond, label %._crit_edge, label %25

._crit_edge:                                      ; preds = %25, %.preheader
  %ans.0.lcssa = phi float [ 0.000000e+00, %.preheader ], [ %34, %25 ]
  %36 = fcmp olt float %ans.0.lcssa, %min_dist.06
  %min_dist.1 = select i1 %36, float %ans.0.lcssa, float %min_dist.06
  %index.2 = select i1 %36, i32 %i.05, i32 %index.17
  %37 = add nsw i32 %i.05, 1
  %exitcond13 = icmp eq i32 %37, %nclusters
  br i1 %exitcond13, label %._crit_edge8, label %.preheader

._crit_edge8:                                     ; preds = %._crit_edge, %.preheader4
  %index.1.lcssa = phi i32 [ %index.010, %.preheader4 ], [ %index.2, %._crit_edge ]
  %38 = getelementptr inbounds i32 addrspace(1)* %membership, i32 %point_id.011
  store i32 %index.1.lcssa, i32 addrspace(1)* %38, align 4, !tbaa !6
  %39 = add i32 %point_id.011, %18
  %40 = icmp ult i32 %39, %npoints
  br i1 %40, label %.preheader4, label %._crit_edge12

._crit_edge12:                                    ; preds = %._crit_edge8, %17
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_size(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, i32 addrspace(1)*, i32, i32, i32, i32, i32)* @kmeans_kernel_c}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3~precise2 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}
