class Orang {
    String name;
    int umur;
    String jk;
    float tb;
    float bb;

    String info() {
        return "Halo, nama saya " + name + ", umur: " + umur + ", jk: " + jk + ", bb: " + bb + ", tb: " + tb;
    }

    int getUmur(){
        return umur;
    }

    void showData() {
        String info = info();
        System.out.println(info);
    }

}

class Mahasiswa extends Orang {
    String nim;
    float ipk;
    String fakultas;
    String jurusan;

    void showDataMhs() {
        String info = info() + ", nim saya: " + nim + ", ipk: " + ipk + ", fakultas :" + fakultas + ", jurusan: "
                + jurusan;

        System.err.println(info);
    }



}

public class Main {
    public static void main(String args[]) {

    
        String name = null;
        System.out.println(
            name.length()
            
        );

    }
}