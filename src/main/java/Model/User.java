package Model;

public class User {
    private int id;
    private String email;
    private String password;
    private String idcard;

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public boolean isRoot() {
        return isRoot;
    }

    public void setRoot(boolean root) {
        isRoot = root;
    }

    private boolean isAdmin=false;
    private boolean isRoot=false;



    public User(int id,String email,String password,String idcard,boolean isAdmin,boolean isRoot)
    {
        this.id=id;
        this.email=email;
        this.password=password;
        this.idcard=idcard;
        this.isAdmin=isAdmin;
        this.isRoot=isRoot;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

}
