public class CUDAEnv {
    public static def getCUDAPlace():Place {
        val naccels = here.numChildren();
        //val gpu = naccels == 0 ? here : here.child(0);
        val gpu = naccels == 0 ? here : here.child(here.id % naccels);
        //Console.OUT.println(here + " has " + naccels + " CUDA places. Will use " + gpu + " as a CUDA place.");
        return gpu;
    }
}
