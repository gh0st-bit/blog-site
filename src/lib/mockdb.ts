// Mock database for development when MongoDB is not available
interface Post {
  _id?: string;
  title: string;
  content: string;
  createdAt?: Date;
}

class MockDatabase {
  private posts: Post[] = [
    {
      _id: '1',
      title: 'Welcome to the Blog!',
      content: 'This is your first blog post. You can create, edit, and delete posts using the form above.',
      createdAt: new Date()
    },
    {
      _id: '2', 
      title: 'Getting Started',
      content: 'To connect to a real MongoDB database, update your MONGODB_URI in .env.local file.',
      createdAt: new Date()
    }
  ];

  async findAll(): Promise<Post[]> {
    return [...this.posts];
  }

  async findById(id: string): Promise<Post | null> {
    return this.posts.find(post => post._id === id) || null;
  }

  async create(data: Omit<Post, '_id'>): Promise<{ insertedId: string }> {
    const newPost: Post = {
      ...data,
      _id: Date.now().toString(),
      createdAt: new Date()
    };
    this.posts.push(newPost);
    return { insertedId: newPost._id! };
  }

  async updateById(id: string, data: Partial<Post>): Promise<{ modifiedCount: number }> {
    const index = this.posts.findIndex(post => post._id === id);
    if (index !== -1) {
      this.posts[index] = { ...this.posts[index], ...data };
      return { modifiedCount: 1 };
    }
    return { modifiedCount: 0 };
  }

  async deleteById(id: string): Promise<{ deletedCount: number }> {
    const index = this.posts.findIndex(post => post._id === id);
    if (index !== -1) {
      this.posts.splice(index, 1);
      return { deletedCount: 1 };
    }
    return { deletedCount: 0 };
  }
}

export const mockDb = new MockDatabase();
