public class CUDAEnv {
    public static def getCUDAPlace():Place {
        val topology = PlaceTopology.getTopology();
        val naccels = topology.numChildren(here);
        //val gpu = naccels == 0 ? here : topology.getChild(here, 0);
        val gpu = naccels == 0 ? here : topology.getChild(here, here.id % naccels);
        //Console.OUT.println(here + " has " + naccels + " CUDA places. Will use " + gpu + " as a CUDA place.");
        return gpu;
    }
}
