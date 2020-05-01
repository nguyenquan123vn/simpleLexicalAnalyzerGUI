package GUI.GUI_controller;

import Lex.Scanner;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.FileChooser;

import java.io.*;
import java.net.URL;
import java.util.ResourceBundle;


public class GUI implements Initializable {
    @FXML
    private Button button;
    @FXML
    private TextArea textArea;

    private String nameFile;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        textArea.setEditable(false);
    }

    public void controlGUI(ActionEvent actionEvent) throws IOException {
        if(actionEvent.getSource() == button){
            FileChooser fileChooser = new FileChooser();
            fileChooser.setTitle("Open Resource File");
            FileChooser.ExtensionFilter fileExtension = new FileChooser.ExtensionFilter("Text Files","*.txt");
            fileChooser.getExtensionFilters().add(fileExtension);
            File selectedFile = fileChooser.showOpenDialog(null);
            if (selectedFile != null) {
                nameFile = selectedFile.getAbsolutePath();
                textArea.clear();
                textArea.setText(Scanner.readFile(nameFile));
            }
        }
    }
}
