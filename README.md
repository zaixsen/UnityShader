# UnityShader
UnityShader

    NnLightMoreColorSphere 不受光照影响的多色彩球
    RefExternalRes 引用外部资源
    DiffuseReflection 漫反射
    RockNormalMap   石头法线贴图
    RimLight   边缘光

    漫反射  

        漫反射（简称漫射，英语：diffuse reflection）是指当一束平行的入射光线射到粗糙的表面时，粗糙的表面会把光线向着各个方向反射的现象。虽然入射线互相平行，由于粗糙的表面上的各点的法线方向不一致，造成反射光线向不同的方向无规则地反射。这种反射的光称为漫射光。很多物体，如沙土、植物、墙壁、衣服等，其表面粗看起来似乎是平滑，但用放大镜仔细观察，就会看到其表面是凹凸不平的，所以本来是平行的太阳光被这些表面反射后，弥漫地射向不同方向。

        兰伯特算法公式
        //图片![6b660dde19f8a62d054bd09736cbe35a](https://github.com/user-attachments/assets/26a9fef4-8799-4660-8eac-32ab66caff6e)

            屏幕上对应点的颜色 = （光的颜色*物体的颜色）* max（0，该点的法向量 ·（点乘） 该点的光照方向） |||  该点的法向量 ·（点乘） 该点的光照方向 取值范围为 [-1,1]
        半兰伯特公式
        //图片![Uploading 9d5ac49a0a882d920f68e8d57507a1c6.png…]()

            该点的法向量 ·（点乘） 该点的光照方向 取值范围为 [0,1]
