import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import os

class ASCIIColorPainter:
    def __init__(self, root):
        self.root = root
        self.root.title("ASCII Art Color Painter")
        self.root.geometry("1000x700")
        
        self.colors = {
            '$1': 'magenta',
            '$2': 'red',
            '$3': 'blue',
            '$4': 'white',
            '$5': 'black',
        }
        
        self.current_color = '$1'
        self.ascii_lines = []
        self.color_data = []
        
        self.setup_ui()
        self.load_ascii_file()
        
    def setup_ui(self):
        main_frame = ttk.Frame(self.root)
        main_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        palette_frame = ttk.LabelFrame(main_frame, text="Color Palette")
        palette_frame.pack(fill=tk.X, pady=(0, 10))
        
        colors_frame = ttk.Frame(palette_frame)
        colors_frame.pack(fill=tk.X, padx=5, pady=5)
        
        for i, (code, color) in enumerate(self.colors.items()):
            btn = tk.Button(colors_frame, text=code, bg=color, fg='black' if color in ['#FFFF00', '#00FFFF', '#FFFFFF'] else 'white',
                           width=5, height=2, command=lambda c=code: self.select_color(c))
            btn.pack(side=tk.LEFT, padx=2)
            
        self.current_color_label = ttk.Label(colors_frame, text=f"Current: {self.current_color}")
        self.current_color_label.pack(side=tk.LEFT, padx=20)
        
        control_frame = ttk.Frame(palette_frame)
        control_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Button(control_frame, text="Load File", command=self.load_file).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Save Colored", command=self.save_colored).pack(side=tk.LEFT, padx=5)
        ttk.Button(control_frame, text="Clear Colors", command=self.clear_colors).pack(side=tk.LEFT, padx=5)
        
        ascii_frame = ttk.LabelFrame(main_frame, text="ASCII Art")
        ascii_frame.pack(fill=tk.BOTH, expand=True)
        
        canvas_frame = ttk.Frame(ascii_frame)
        canvas_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.canvas = tk.Canvas(canvas_frame, bg='black')
        v_scrollbar = ttk.Scrollbar(canvas_frame, orient=tk.VERTICAL, command=self.canvas.yview)
        h_scrollbar = ttk.Scrollbar(canvas_frame, orient=tk.HORIZONTAL, command=self.canvas.xview)
        
        self.canvas.configure(yscrollcommand=v_scrollbar.set, xscrollcommand=h_scrollbar.set)
        
        v_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        h_scrollbar.pack(side=tk.BOTTOM, fill=tk.X)
        self.canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        self.canvas.bind("<Button-1>", self.on_click)
        self.canvas.bind("<B1-Motion>", self.on_drag)
        
    def load_ascii_file(self):
        try:
            if os.path.exists("ascii/teto_hires.txt"):
                with open("ascii/teto_hires.txt", 'r', encoding='utf-8') as f:
                    self.ascii_lines = f.readlines()
                self.ascii_lines = [line.rstrip('\n\r') for line in self.ascii_lines]
                self.initialize_color_data()
                self.draw_ascii()
            else:
                messagebox.showwarning("File Not Found", "ascii/teto_hires.txt not found. Please load a file manually.")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to load file: {str(e)}")
            
    def load_file(self):
        file_path = filedialog.askopenfilename(
            title="Select ASCII Art File",
            filetypes=[("Text files", "*.txt"), ("All files", "*.*")]
        )
        if file_path:
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    self.ascii_lines = f.readlines()
                self.ascii_lines = [line.rstrip('\n\r') for line in self.ascii_lines]
                self.initialize_color_data()
                self.draw_ascii()
            except Exception as e:
                messagebox.showerror("Error", f"Failed to load file: {str(e)}")
                
    def initialize_color_data(self):
        self.color_data = []
        for line in self.ascii_lines:
            line_colors = ['$1'] * len(line)
            self.color_data.append(line_colors)
            
    def select_color(self, color_code):
        self.current_color = color_code
        self.current_color_label.config(text=f"Current: {self.current_color}")
        
    def draw_ascii(self):
        self.canvas.delete("all")
        
        if not self.ascii_lines:
            return
            
        font_size = 12
        char_width = 8
        char_height = 16
        
        for row, line in enumerate(self.ascii_lines):
            for col, char in enumerate(line):
                if char.strip():
                    x = col * char_width + 10
                    y = row * char_height + 20
                    
                    color_code = self.color_data[row][col] if col < len(self.color_data[row]) else '$1'
                    color = self.colors.get(color_code, self.colors['$1'])
                    
                    text_id = self.canvas.create_text(x, y, text=char, fill=color, 
                                                    font=('Courier', font_size), anchor='nw',
                                                    tags=f"char_{row}_{col}")
        
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))
        
    def get_char_position(self, event):
        char_width = 8
        char_height = 16
        
        canvas_x = self.canvas.canvasx(event.x)
        canvas_y = self.canvas.canvasy(event.y)
        
        col = int((canvas_x - 10) // char_width)
        row = int((canvas_y - 20) // char_height)
        
        return row, col
        
    def paint_character(self, row, col):
        if (0 <= row < len(self.ascii_lines) and 
            0 <= col < len(self.ascii_lines[row]) and
            self.ascii_lines[row][col].strip()):
            
            while len(self.color_data) <= row:
                self.color_data.append([])
            while len(self.color_data[row]) <= col:
                self.color_data[row].append('$1')
                
            self.color_data[row][col] = self.current_color
            self.draw_ascii()
            
    def on_click(self, event):
        row, col = self.get_char_position(event)
        self.paint_character(row, col)
        
    def on_drag(self, event):
        row, col = self.get_char_position(event)
        self.paint_character(row, col)
        
    def clear_colors(self):
        if messagebox.askyesno("Clear Colors", "Are you sure you want to reset all colors to $1?"):
            self.initialize_color_data()
            self.draw_ascii()
            
    def save_colored(self):
        if not self.ascii_lines:
            messagebox.showwarning("No Data", "No ASCII art loaded to save.")
            return
            
        try:
            os.makedirs("ascii", exist_ok=True)
            
            with open("ascii/teto_hires_colored.txt", 'w', encoding='utf-8') as f:
                for row, line in enumerate(self.ascii_lines):
                    colored_line = ""
                    current_color = None
                    
                    for col, char in enumerate(line):
                        char_color = self.color_data[row][col] if col < len(self.color_data[row]) else '$1'
                        
                        if char_color != current_color:
                            colored_line += char_color
                            current_color = char_color
                            
                        colored_line += char
                    
                    f.write(colored_line + '\n')
                    
            messagebox.showinfo("Success", "Colored ASCII art saved to ascii/teto_hires_colored.txt")
            
        except Exception as e:
            messagebox.showerror("Error", f"Failed to save file: {str(e)}")

def main():
    root = tk.Tk()
    app = ASCIIColorPainter(root)
    root.mainloop()

if __name__ == "__main__":
    main()
