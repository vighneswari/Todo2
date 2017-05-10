package com.test;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;

@PersistenceCapable
public class ToStoreNote {
@Persistent
private String note;

public String getnote() {
return note;
}
public void setnote(String note) {
this.note = note;
}
}