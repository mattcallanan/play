import com.couchbase.client.CouchbaseClient;
import net.spy.memcached.internal.GetFuture;
import net.spy.memcached.internal.OperationFuture;

import java.io.IOException;
import java.net.URI;
import java.util.List;
import java.util.concurrent.TimeUnit;

import static java.util.Collections.singletonList;

public class Main {
    public static final int EXP_TIME = 10;
    public static final String KEY = "spoon";
    public static final String VALUE = "Hello World!";
    //    public static final String SERVER = "ec2-175-41-156-165.ap-southeast-1.compute.amazonaws.com";
    public static final String SERVER = "localhost";
    public static final Boolean DO_DELETE = false;

    public static void main(String args[]) {
        CouchbaseClient client = tryConnect(singletonList(URI.create("http://" + SERVER + ":8091/pools")));
        // Do a synchrononous get
        Object getObject = client.get(KEY);
        // Do an asynchronous set
        OperationFuture<Boolean> setOp = client.set(KEY, EXP_TIME, VALUE);
        // Do an asynchronous get
        GetFuture getOp = client.asyncGet(KEY);
        // Do an asynchronous delete
        OperationFuture<Boolean> delOp = null;
        if (DO_DELETE) delOp = client.delete(KEY);
        // Shutdown the client
        client.shutdown(3, TimeUnit.SECONDS);
        // Now we want to see what happened with our data
        // Check to see if our set succeeded
        try {
            if (setOp.get().booleanValue()) {
                System.out.println("Set Succeeded");
            } else {
                System.err.println("Set failed: " + setOp.getStatus().getMessage());
            }
        } catch (Exception e) {
            System.err.println("Exception while doing set: " + e.getMessage());
        }
        // Print the value from synchronous get
        if (getObject != null) {
            System.out.println("Synchronous Get Suceeded: " + (String) getObject);
        } else {
            System.err.println("Synchronous Get failed");
        }
        // Check to see if ayncGet succeeded
        try {
            if ((getObject = getOp.get()) != null) {
                System.out.println("Asynchronous Get Succeeded: " + getObject);
            } else {
                System.err.println("Asynchronous Get failed: " + getOp.getStatus().getMessage());
            }
        } catch (Exception e) {
            System.err.println("Exception while doing Aynchronous Get: " + e.getMessage());
        }
        // Check to see if our delete succeeded
        if (DO_DELETE) {
            try {
                if (delOp.get().booleanValue()) {
                    System.out.println("Delete Succeeded");
                } else {
                    System.err.println("Delete failed: " + delOp.getStatus().getMessage());
                }
            } catch (Exception e) {
                System.err.println("Exception while doing delete: " + e.getMessage());
            }
        }
    }

    private static CouchbaseClient tryConnect(List<URI> uris) {
        try {
            return new CouchbaseClient(uris, "default", "", "");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}